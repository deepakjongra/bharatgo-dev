
-- users tables------------------------------------------------------------

-- user_master- done
CREATE TABLE user_master (
	id bigserial NOT NULL,
	row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	user_emailid varchar(60) NULL DEFAULT ''::character varying,
	user_mobileno varchar(60) NULL DEFAULT ''::character varying,
	user_address varchar(60) NULL DEFAULT ''::character varying,
	user_city varchar(60) NULL DEFAULT ''::character varying,
	user_firstname varchar(60) NULL,
	user_middlename varchar(60) NULL,
	user_lastname varchar(60) NULL,
	is_approved int4 NULL,
	user_password varchar(255) NULL,
	date_of_birth varchar(10) NULL,
	user_role_id int8 NOT NULL,
	created_by int8 NULL DEFAULT 0,
	modified_by int8 NULL DEFAULT 0,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL,
	share_mobile_no bool NULL,
	profile_image_id int8 NULL,
	agent_code varchar(20) NULL,
	age int4 NULL,
	is_verified bool NULL DEFAULT false,
	CONSTRAINT pk_user_master PRIMARY KEY (id),
	CONSTRAINT user_master_un UNIQUE (row_uuid),
	CONSTRAINT fk_user_master_1 FOREIGN KEY (user_role_id) REFERENCES role_master(role_id),
	CONSTRAINT user_master_fk FOREIGN KEY (profile_image_id) REFERENCES file_storage_master(id)
);

-- user_addresses_master-
CREATE TABLE user_addresses_master (
	id bigserial NOT NULL,
	row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	latitude varchar(100) NULL,
	longitude varchar(100) NULL,
	house_no varchar(100) NULL,
	area_street varchar(100) NULL,
	landmark varchar(50) NULL,
	user_id int8 NOT NULL,
	city_id int8 NULL,
	city_area_id int8 NULL,
	ward_id int8 NULL,
	created_by int8 NULL DEFAULT 0,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_by int8 NULL DEFAULT 0,
	modified_on timestamp NULL,
	is_active int4 NULL DEFAULT 1,
	pincode int8 NULL,
	pincode_area varchar(50) NULL,
	area_name varchar(50) NULL,
	building_name varchar(200) NULL,
	location_url varchar(500) NULL,
	CONSTRAINT pk_user_addresses_master PRIMARY KEY (id),
	CONSTRAINT user_addresses_master_un UNIQUE (row_uuid),
	CONSTRAINT fk_user_addresses_master_1 FOREIGN KEY (city_id) REFERENCES city_master(id),
	CONSTRAINT fk_user_addresses_master_3 FOREIGN KEY (ward_id) REFERENCES ward_master(id),
	CONSTRAINT fk_user_addresses_master_4 FOREIGN KEY (user_id) REFERENCES user_master(id)
);

-- user_coins_master- done
CREATE TABLE user_coins_master (
	id bigserial NOT NULL,
	row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	user_id int8 NULL,
	remaining_coins numeric(7, 3) NULL,
	redeemed_coins numeric(7, 3) NULL,
	created_by int8 NULL DEFAULT 0,
	modified_by int8 NULL DEFAULT 0,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL,
	CONSTRAINT pk_user_coins_master_id PRIMARY KEY (id),
	CONSTRAINT user_coins_master_un UNIQUE (row_uuid),
	CONSTRAINT user_coins_master_fk FOREIGN KEY (user_id) REFERENCES user_master(id)
);

-- user_accessed_locations_master -
CREATE TABLE user_accessed_locations_master (
	id bigserial NOT NULL,
	row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	user_id int8 NULL,
	ward_id int8 NULL,
	pincode_id int8 NULL,
	latitude varchar(30) NULL,
	longitude varchar(30) NULL,
	created_by int8 NULL,
	modified_by int8 NULL,
	created_on timestamptz NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL DEFAULT 1,
	CONSTRAINT pk_user_accessed_locations_master PRIMARY KEY (id),
	CONSTRAINT user_accessed_locations_master_un UNIQUE (row_uuid),
	CONSTRAINT user_accessed_locations_master_fk FOREIGN KEY (user_id) REFERENCES user_master(id),
	CONSTRAINT user_accessed_locations_master_fk1 FOREIGN KEY (ward_id) REFERENCES ward_master(id),
	CONSTRAINT user_accessed_locations_master_fk2 FOREIGN KEY (pincode_id) REFERENCES pincode_master(id)
)

-- user_device_tokens_mapping- done
CREATE TABLE user_device_tokens_mapping (
	id bigserial NOT NULL,
	row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	device_type varchar(60) NULL,
	device_token varchar(100) NULL,
	user_id int8 NULL,
	user_role_id int8 NULL,
	created_by int8 NULL,
	modified_by int8 NULL,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL DEFAULT 1,
	CONSTRAINT pk_user_device_mapping PRIMARY KEY (id),
	CONSTRAINT user_devices_mapping_un UNIQUE (row_uuid),
	CONSTRAINT fk_user_device_mapping1 FOREIGN KEY (user_role_id) REFERENCES role_master(role_id)
);

-- user_events_master-  done
CREATE TABLE user_events_master (
	id bigserial NOT NULL,
	row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	user_id int8 NULL,
	event_name varchar(30) NULL,
	platform varchar(20) NULL,
	project varchar(20) NULL,
	properties jsonb NULL,
	created_by int8 NULL DEFAULT 0,
	modified_by int8 NULL DEFAULT 0,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL,
	CONSTRAINT pk_user_events_master_id PRIMARY KEY (id),
	CONSTRAINT user_events_master_un UNIQUE (row_uuid),
	CONSTRAINT user_events_master_fk1 FOREIGN KEY (user_id) REFERENCES user_master(id)
);

-- user_sessions_master- done
CREATE TABLE user_sessions_master (
	id bigserial NOT NULL,
	reference_id int8 NULL,
	session_id varchar(100) NULL,
	created_by int8 NULL DEFAULT 0,
	modified_by int8 NULL DEFAULT 0,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL,
	reference_type varchar(20) NULL,
	CONSTRAINT pk_user_sessions_master_id PRIMARY KEY (id)
);

-- user_session_events_master- done
CREATE TABLE user_session_events_master (
	id bigserial NOT NULL,
	user_session_id int8 NULL,
	session_id varchar(100) NULL,
	event_type varchar(100) NULL,
	platform varchar(20) NULL,
	project varchar(20) NULL,
	payload jsonb NULL,
	created_by int8 NULL DEFAULT 0,
	modified_by int8 NULL DEFAULT 0,
	created_on timestamp NULL DEFAULT now()::timestamp without time zone,
	modified_on timestamp NULL,
	is_active int4 NULL,
	CONSTRAINT pk_user_session_events_master_id PRIMARY KEY (id),
	CONSTRAINT user_session_events_master_fk1 FOREIGN KEY (user_session_id) REFERENCES user_sessions_master(id)
);


-- vendor-user tables ---------------------------------------------------

-- vendor_business_user_ratings_master- done
CREATE TABLE vendor_business_user_ratings_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id int8 NULL,
    vendor_business_id int8 NULL,
    ratings int4 NULL,
    created_by int8 NULL,
    modified_by int8 NULL,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL DEFAULT 1,
    rating_type varchar(50) NULL,
    reference_id int8 NULL,
    reference_table varchar(100) NULL,
    CONSTRAINT pk_vendor_business_user_ratings_master PRIMARY KEY (id),
    CONSTRAINT vendor_business_user_ratings_master_check CHECK (((ratings >= 0) AND (ratings <= 5))),
    CONSTRAINT vendor_business_user_ratings_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_business_user_ratings_master_fk1 FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id),
    CONSTRAINT vendor_business_user_ratings_master_fk2 FOREIGN KEY (user_id) REFERENCES user_master(id)
);

-- vendor_business_user_subscribe_master- done
CREATE TABLE vendor_business_user_subscribe_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    vendor_business_id int8 NULL,
    user_id int8 NULL,
    subscibe_status varchar(20) NULL,
    subscribed_date timestamp NULL,
    unsubscribed_date timestamp NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    CONSTRAINT pk_vendor_business_user_subscribe_master_id PRIMARY KEY (id),
    CONSTRAINT vendor_business_user_subscribe_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_business_user_subscribe_master_fk1 FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id),
    CONSTRAINT vendor_business_user_subscribe_master_fk2 FOREIGN KEY (user_id) REFERENCES user_master(id)
);

-- vendor_customer_loyality_program_users_mapping_master- done
CREATE TABLE vendor_customer_loyality_program_users_mapping_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    vendor_loyality_program_id int8 NULL,
    user_id int8 NULL,
    reward numeric(7, 2) NULL,
    points int8 NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    is_first_time bool NULL,
    original_amount numeric(7, 2) NULL,
    "type" varchar(30) NULL,
    vendor_business_id int8 NULL,
    coins_redeemed numeric(7, 2) NULL DEFAULT 0,
    coins_earned numeric(7, 2) NULL DEFAULT 0,
    CONSTRAINT pk_vendor_customer_loyality_program_users_mapping_master_id PRIMARY KEY (id),
    CONSTRAINT vendor_customer_loyality_program_users_mapping_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_customer_loyality_program_users_mapping_master_fk FOREIGN KEY (vendor_loyality_program_id) REFERENCES vendor_customer_loyality_program_master(id),
    CONSTRAINT vendor_customer_loyality_program_users_mapping_master_fk1 FOREIGN KEY (user_id) REFERENCES user_master(id),
    CONSTRAINT vendor_customer_loyality_program_users_mapping_master_fk3 FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id)
);

-- vendor_qr_scanned_history_master- done
CREATE TABLE vendor_qr_scanned_history_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    vendor_business_id int8 NULL,
    user_id int8 NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    is_first_time bool NULL,
    CONSTRAINT pk_vendor_qr_scanned_history_master_id PRIMARY KEY (id),
    CONSTRAINT vendor_qr_scanned_history_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_qr_scanned_history_master_fk FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id),
    CONSTRAINT vendor_qr_scanned_history_master_fk1 FOREIGN KEY (user_id) REFERENCES user_master(id)
);

-- vendor_account_settlement_master- done
CREATE TABLE vendor_account_settlement_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    vendor_reference_id int8 NULL,
    vendor_type varchar(30) NULL,
    amount_to_be_settled numeric(7, 3) NULL,
    amount_collected numeric(7, 3) NULL,
    vendor_discount numeric(7, 3) NULL,
    dwarbuddy_discount numeric(7, 3) NULL,
    dwarbuddy_tax numeric(7, 3) NULL,
    reference_id int8 NULL,
    reference_type varchar(30) NULL,
    settlement_status varchar(30) NULL,
    created_by int8 NULL,
    modified_by int8 NULL,
    created_on timestamptz NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL DEFAULT 1,
    coins_redeemed numeric(7, 2) NULL DEFAULT 0,
    coins_earned numeric(7, 2) NULL DEFAULT 0,
    transaction_id varchar(50) NULL,
    CONSTRAINT pk_vendor_account_settlement_master PRIMARY KEY (id),
    CONSTRAINT vendor_account_settlement_master_un UNIQUE (row_uuid)
);

-- vendor_business_notifications_master- done
CREATE TABLE vendor_business_notifications_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    title varchar(250) NULL,
    description varchar(250) NULL,
    notification_type varchar(50) NULL,
    vendor_business_id int8 NULL,
    sqs_task_id int8 NULL,
    remaining int8 NULL,
    successful int8 NULL,
    failed int8 NULL,
    errored int8 NULL,
    received int8 NULL,
    created_by int8 NULL,
    modified_by int8 NULL,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL DEFAULT 1,
    recepients int8 NULL,
    CONSTRAINT pk_vendor_business_notifications_master PRIMARY KEY (id),
    CONSTRAINT vendor_business_notifications_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_business_notifications_master_fk1 FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id),
    CONSTRAINT vendor_business_notifications_master_fk2 FOREIGN KEY (sqs_task_id) REFERENCES sqs_tasks_master(id)
);

-- vendor_business_offers_master- done
CREATE TABLE vendor_business_offers_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    title varchar(100) NULL,
    description text NULL,
    coupon_id int8 NULL,
    discount_type varchar(20) NULL,
    amount varchar(40) NULL,
    minimum_purchase varchar(40) NULL,
    maximum_discount varchar(40) NULL,
    offer_valid_from date NULL,
    offer_valid_till date NULL,
    vendor_business_id int8 NOT NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    image_id int8 NULL,
    status varchar(10) NULL,
    CONSTRAINT pk_vendor_business_offers_master_id PRIMARY KEY (id),
    CONSTRAINT vendor_business_offers_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_business_offers_master_fk1 FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id),
    CONSTRAINT vendor_business_offers_master_fk2 FOREIGN KEY (coupon_id) REFERENCES coupon_code_master(id),
    CONSTRAINT vendor_business_offers_master_fk3 FOREIGN KEY (image_id) REFERENCES file_storage_master(id)
);

-- vendor_business_products_orders_master-
CREATE TABLE vendor_business_products_orders_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    order_number varchar(60) NOT NULL,
    order_date date NOT NULL,
    order_ship_date date NULL,
    order_status varchar(50) NOT NULL,
    order_id int8 NULL,
    coupon_code varchar(20) NULL,
    vendor_category_id int8 NOT NULL,
    vendor_business_id int8 NOT NULL,
    vendor_business_offer_id int8 NULL,
    final_amount numeric(7, 3) NOT NULL,
    total_amount numeric(7, 3) NOT NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    delivery_fee int8 NULL,
    coupon_code_id int8 NULL,
    discount numeric(7, 3) NULL,
    CONSTRAINT pk_vendor_business_products_orders_master_id PRIMARY KEY (id),
    CONSTRAINT vendor_business_products_orders_master_un UNIQUE (row_uuid),
    CONSTRAINT vendor_business_products_orders_master_fk1 FOREIGN KEY (vendor_business_id) REFERENCES vendor_businesses_master(id),
    CONSTRAINT vendor_business_products_orders_master_fk2 FOREIGN KEY (vendor_category_id) REFERENCES vendor_category_master(id),
    CONSTRAINT vendor_business_products_orders_master_fk3 FOREIGN KEY (order_id) REFERENCES products_orders_master(id),
    CONSTRAINT vendor_business_products_orders_master_fk4 FOREIGN KEY (vendor_business_offer_id) REFERENCES vendor_business_offers_master(id),
    CONSTRAINT vendor_business_products_orders_master_fk5 FOREIGN KEY (coupon_code_id) REFERENCES coupon_code_master(id)
);


-- products table -----------------------------------------------------------------

-- products_orders_master-
CREATE TABLE products_orders_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    order_number varchar(60) NOT NULL,
    order_date date NOT NULL,
    order_ship_date date NULL,
    order_status varchar(50) NOT NULL,
    user_id int8 NOT NULL,
    dwarbuddy_offer_id int8 NULL,
    coupon_code varchar(20) NULL,
    order_final_amount numeric(7, 3) NOT NULL,
    order_total_amount numeric(7, 3) NOT NULL,
    order_ship_address varchar(100) NULL,
    order_city varchar(50) NULL,
    order_state varchar(50) NULL,
    order_pincode varchar(20) NULL,
    order_country varchar(20) NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    delivery_timing varchar(20) NULL,
    delivery_type varchar(50) NULL,
    payment_mode varchar(20) NULL,
    delivery_fee int8 NULL,
    is_first_time bool NULL,
    discount numeric(7, 3) NULL,
    user_address_id int8 NULL,
    CONSTRAINT pk_products_orders_master_id PRIMARY KEY (id),
    CONSTRAINT products_orders_master_un UNIQUE (row_uuid),
    CONSTRAINT products_orders_master_fk FOREIGN KEY (user_id) REFERENCES user_master(id),
    CONSTRAINT products_orders_master_fk3 FOREIGN KEY (dwarbuddy_offer_id) REFERENCES dwarbuddy_global_offers_master(id),
    CONSTRAINT products_orders_master_fk4 FOREIGN KEY (user_address_id) REFERENCES user_addresses_master(id)
);

-- product_order_details_master-
CREATE TABLE product_order_details_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    final_price numeric(7, 3) NULL,
    product_name varchar(255) NOT NULL,
    product_desc text NULL,
    quantity_per_unit int8 NULL,
    unit_mrp numeric(7, 3) NOT NULL,
    unit_sale_price numeric(7, 3) NOT NULL,
    unit_weight varchar(60) NOT NULL,
    unit_weight_type varchar(20) NULL,
    product_available varchar(10) NULL,
    quantity int8 NOT NULL,
    discount numeric(7, 3) NULL,
    product_image_id int8 NULL,
    product_id int8 NOT NULL,
    global_product_id int8 NULL,
    order_id int8 NULL,
    vendor_business_order_id int8 NULL,
    flash_sale_id int8 NULL,
    is_custom_product bool NULL DEFAULT false,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    vendor_comment varchar(100) NULL,
    CONSTRAINT pk_product_order_details_master_id PRIMARY KEY (id),
    CONSTRAINT product_order_details_master_un UNIQUE (row_uuid),
    CONSTRAINT product_order_details_master_fk1 FOREIGN KEY (product_image_id) REFERENCES file_storage_master(id),
    CONSTRAINT product_order_details_master_fk2 FOREIGN KEY (product_id) REFERENCES vendor_products_master(id),
    CONSTRAINT product_order_details_master_fk3 FOREIGN KEY (global_product_id) REFERENCES global_products_master(id),
    CONSTRAINT product_order_details_master_fk4 FOREIGN KEY (order_id) REFERENCES products_orders_master(id),
    CONSTRAINT product_order_details_master_fk5 FOREIGN KEY (vendor_business_order_id) REFERENCES vendor_business_products_orders_master(id),
    CONSTRAINT product_order_details_master_fk6 FOREIGN KEY (flash_sale_id) REFERENCES products_flash_sale_master(id)
);

-- product_order_status_master-
CREATE TABLE product_order_status_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    order_id int8 NULL,
    order_status varchar(30) NULL,
    created_by int8 NULL,
    modified_by int8 NULL,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL DEFAULT 1,
    CONSTRAINT pk_product_order_status_master PRIMARY KEY (id),
    CONSTRAINT product_order_status_master_un UNIQUE (row_uuid),
    CONSTRAINT product_order_status_master_fk4 FOREIGN KEY (order_id) REFERENCES products_orders_master(id)
);

-- product_orders_payment_details_mapping_master-
CREATE TABLE product_orders_payment_details_mapping_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    order_id int8 NULL,
    payment_id int8 NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    payment_mode varchar(30) NULL,
    payment_status varchar(20) NULL,
    CONSTRAINT pk_product_orders_payment_details_mapping_master_id PRIMARY KEY (id),
    CONSTRAINT product_orders_payment_details_mapping_master_un UNIQUE (row_uuid),
    CONSTRAINT product_orders_payment_details_mapping_master_fk FOREIGN KEY (order_id) REFERENCES products_orders_master(id),
    CONSTRAINT product_orders_payment_details_mapping_master_fk1 FOREIGN KEY (payment_id) REFERENCES rzp_payment_details_master(id)
);

-- products_todays_deals_master- done
CREATE TABLE products_todays_deals_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    app_price numeric(7, 2) NULL,
    max_quantity int4 NULL,
    expiry_date date NOT NULL,
    offer_text varchar(100) NULL,
    global_product_id int8 NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    CONSTRAINT pk_products_todays_deals_master_id PRIMARY KEY (id),
    CONSTRAINT products_todays_deals_master_un UNIQUE (row_uuid),
    CONSTRAINT products_todays_deals_master_fk1 FOREIGN KEY (global_product_id) REFERENCES vendor_products_master(id)
);

-- products_todays_deals_shop_category_mapping_master-done
CREATE TABLE products_todays_deals_shop_category_mapping_master (
    id bigserial NOT NULL,
    row_uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
    deal_id int8 NOT NULL,
    shop_category_id int8 NOT NULL,
    created_by int8 NULL DEFAULT 0,
    modified_by int8 NULL DEFAULT 0,
    created_on timestamp NULL DEFAULT now()::timestamp without time zone,
    modified_on timestamp NULL,
    is_active int4 NULL,
    CONSTRAINT pk_products_todays_deals_shop_category_mapping_master_id PRIMARY KEY (id),
    CONSTRAINT products_todays_deals_shop_category_mapping_master_un UNIQUE (row_uuid),
    CONSTRAINT products_todays_deals_shop_category_mapping_master_fk1 FOREIGN KEY (deal_id) REFERENCES products_todays_deals_master(id),
    CONSTRAINT products_todays_deals_shop_category_mapping_master_fk2 FOREIGN KEY (shop_category_id) REFERENCES shops_category_master(id)
);



-- completed tables--------------------------------------------------------------------
-- products_category_master-
-- products_subcategory_master-
-- otp_generate_master-
-- rzp_payment_details_master-
-- rzp_webhook_details_master-
-- vendors_master-
-- vendor_category_master-
-- vendor_businesses_master-
-- vendor_business_application_status_master-
-- vendor_bio_shop_images_mapping_master-
-- vendor_bank_accounts_master-
-- vendor_business_bank_account_mapping_master-
-- vendor_payment_modes_master-
-- vendor_delivery_types_master-
-- vendor_business_qr_code_mapping_master-
-- vendor_business_plans_master-
-- vendors_business_plans_mapping_master-
-- vendor_business_plan_payment_details_mapping_master-
-- vendor_business_delivery_type_mapping_master-
-- vendor_business_payment_mode_mapping_master-
-- vendor_customer_loyality_program_master-
-- vendor_kyc_documents_mapping_master-
-- vendor_kyc_verifications_master-
-- vendor_products_master-
-- vendor_products_category_mapping_master-
-- vendor_products_sub_category_mapping_master-
-- vendor_shops_images_mapping_master-

