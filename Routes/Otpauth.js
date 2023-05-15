const express = require("express");
const jwt = require('jsonwebtoken')
const router = express.Router();
const pool = require("../Config/DatabaseConfig");

router.use(express.json());

// router.post("/otp/register", async (req, res) => {
//   try {
//     const temp_secret = speakeasy.generateSecret({ length: 20 }).base32;
//     const token = speakeasy.totp({
//       secret: temp_secret,
//       encoding: "base32",
//       // step: 300,
//     });
//     const time = new Date();
//     const exp_time = new Date(time.getTime() + 5 * 60000);
//     const result = await pool.query(
//       "insert into otp_generate_master (otp,otp_expiry_date) values($1, $2) returning otp",
//       [token, exp_time]
//     );
//     res.status(201).json(result.rows[0]);
//   } catch (err) {
//     res.send("something went wrong").status(401);
//     console.log(err);
//   }
// });

// router.post("/otp/verify", async (req, res) => {
//   try {
//     const { id, userOtp } = req.body;
//     console.log(userOtp)
//     const result = await pool.query(
//       "select * from otp_generate_master where id= $1",
//       [id]
//     );
//     const { otp } = result.rows[0];
//     const verified = speakeasy.totp.verify({
//       secret: otp,
//       encoding: "base32",
//       token: userOtp,
//       // step: 300,
//     });
//     if (verified) {
//       res.status(201).send("ping pong welcome otp verfied");
//     }
//     res.status(403).send("invalid otp");
//   } catch (error) {
//     res.status(500);
//   }
// });

router.post("/login", async (req, res) => {
  const { number } = req.body;

  // Generate a random OTP
  const otp = Math.floor(100000 + Math.random() * 900000);

  // Set the OTP expiry time (e.g., 5 minutes from the current time)
  const expiryTime = new Date();
  expiryTime.setMinutes(expiryTime.getMinutes() + 2);

  try {
    // Insert the OTP into the database
    await pool.query(
      "INSERT INTO otp_generate_master (login_id, otp, otp_expiry_date) VALUES ($1, $2, $3)",
      [number, otp, expiryTime]
    );

    res.json({ otp: otp });
  } catch (error) {
    console.error("Error generating OTP:", error);
    res.status(500).json({ error: "Failed to generate OTP" });
  }
});

router.post("/validateOtp", async (req, res) => {
  const { number, otp } = req.body;

  try {
    // Fetch the OTP details from the database
    const result = await pool.query(
      "SELECT otp_expiry_date FROM otp_generate_master WHERE login_id = $1 AND otp = $2",
      [number, otp]
    );

    if (result.rows.length > 0) {
      const otpExpiryDate = new Date(result.rows[0].otp_expiry_date);

      // Check if the OTP has expired
      if (otpExpiryDate > new Date()) {
       const token =   jwt.sign({
            login_id:number,
          },process.env.JWT_SECRET,{expiresIn: '24h'})
        res.send({token});
      } else {
        res.send("OTP Expired");
      }
    } else {
      res.send("Invalid OTP");
    }
  } catch (error) {
    console.error("Error validating OTP:", error);
    res.status(500).json({ error: "Failed to validate OTP" });
  }
});


router.post('/vendor-businesses', async (req, res) => {
  try {
    const {
      name,
      shopAddress,
      geolocationUrl,
      buildingName,
      streetName,
      landmark,
      latitude,
      longitude,
      vendorCategoryId,
      pincode,
      whatsappMobileNo,
      shopCategory,
      personalKyc,
      businessKyc,
      listingType,
      ownerDetails,
      shopImages,
      vendorId,
      businessType,
      bdeCode,
    } = req.body;

    // Execute the INSERT query
    const result = await pool.query(
      `INSERT INTO vendor_businesses_master (
        row_uuid,
        business_name,
        business_desc,
        geolocation,
        building_name,
        street_name,
        landmark,
        latitude,
        longitude,
        vendor_category_id,
        postal_code,
        business_whatsapp_number,
        shop_category_id,
        business_type_id,
      ) VALUES (
        uuid_generate_v4(), $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14
      )`,
      [
        name,
        shopAddress,
        geolocationUrl,
        buildingName,
        streetName,
        landmark,
        latitude,
        longitude,
        vendorCategoryId,
        pincode,
        whatsappMobileNo,
        shopCategory,
        businessType
      ]
    );

    res.status(201).json(result.rows);
  } catch (error) {
    console.error('Error saving vendor business:', error);
    res.status(500).json({ error: 'Failed to save vendor business' });
  }
});



module.exports = router;
