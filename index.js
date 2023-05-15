const express = require("express");
var cors = require("cors");
require("dotenv").config();

const app = express();

app.use(express.json());
app.use(cors());

app.use(require("./Routes/Otpauth"));

app.listen(8080, () => {
  console.log(`running on http://localhost:8080`);
});
