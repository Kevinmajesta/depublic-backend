/*
 Navicat Premium Data Transfer

 Source Server         : depublic
 Source Server Type    : PostgreSQL
 Source Server Version : 160003 (160003)
 Source Host           : localhost:5432
 Source Catalog        : depublic
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 160003 (160003)
 File Encoding         : 65001

 Date: 23/06/2024 19:52:05
*/


-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS "public"."carts";
CREATE TABLE "public"."carts" (
  "cart_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "event_id" uuid NOT NULL,
  "qty" int4 NOT NULL,
  "ticket_date" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "price" int8 NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO "public"."carts" VALUES ('ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '8a5d4900-8d8d-f7e0-74ee-287fe6b5f52a', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 2, '2003-07-17', 838, '2002-06-22 23:09:42+00', '2009-05-17 03:42:38+00', '2001-02-08 04:52:02+00');
INSERT INTO "public"."carts" VALUES ('ce79b6cf-58b7-4e5c-a787-fb2ffe29fca7', '07b553ae-736f-4f5a-aaf7-343457cab5ba', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 1, '2024-06-14T00:00:00Z', 100000, '2024-06-20 17:25:58.490363+00', '2024-06-20 17:25:58.490363+00', NULL);
INSERT INTO "public"."carts" VALUES ('c857a8d8-55b0-4298-b1b0-63ad860f65e6', '07b553ae-736f-4f5a-aaf7-343457cab5bd', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 1, '2024-06-14T00:00:00Z', 100000, '2024-06-20 17:23:35.702289+00', '2024-06-20 17:23:35.702289+00', NULL);

-- ----------------------------
-- Table structure for event_categories
-- ----------------------------
DROP TABLE IF EXISTS "public"."event_categories";
CREATE TABLE "public"."event_categories" (
  "event_categories_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name_categories" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of event_categories
-- ----------------------------
INSERT INTO "public"."event_categories" VALUES ('cc98af8f-953c-4b2c-b7ef-767e1e3d21ba', 'Test Update 1', '2024-06-21 17:01:08.193456+00', '2024-06-21 18:55:59.989049+00', NULL);
INSERT INTO "public"."event_categories" VALUES ('00000000-0000-0000-0000-000000000000', 'Test Update 1', '2024-06-21 18:56:32.612297+00', '2024-06-21 18:56:32.612297+00', NULL);

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS "public"."events";
CREATE TABLE "public"."events" (
  "event_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "category_id" uuid NOT NULL,
  "title_event" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "date_event" date NOT NULL,
  "price_event" int8 NOT NULL,
  "city_event" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "address_event" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "qty_event" int8 NOT NULL,
  "description_event" text COLLATE "pg_catalog"."default" NOT NULL,
  "image_url" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO "public"."events" VALUES ('8079389b-a711-4001-948f-cf29731171e0', 'cc98af8f-953c-4b2c-b7ef-767e1e3d21ba', 'Test10', '2024-06-30', 1000, 'Semarang', 'Sampokong', 3000, 'Konser Tour Hindia', '/assets/images/726cd8d2-474e-4e11-9017-6fae605c9865.jpeg', '2024-06-21 16:07:52.479305+00', '2024-06-21 16:07:52.479305+00', NULL);
INSERT INTO "public"."events" VALUES ('89cb0582-396d-42f8-8d0b-e0eceffa800c', 'cc98af8f-953c-4b2c-b7ef-767e1e3d21ba', 'Test10', '2024-06-29', 1000, 'Semarang', 'Sampokong', 3000, 'Konser Tour Hindia', '/assets/images/8a4a6794-3eb1-4f71-9eb9-843e72321d09.mp4', '2024-06-21 16:19:41.46477+00', '2024-06-21 16:19:41.46477+00', NULL);
INSERT INTO "public"."events" VALUES ('c71e5933-0ab2-4fc3-a6e1-41b44bdfa57f', 'cc98af8f-953c-4b2c-b7ef-767e1e3d21ba', 'Test10', '2024-06-28', 1000, 'Semarang', 'Sampokong', 3000, 'Konser Tour Hindia', '/assets/images/3ba2fd75-99f4-45cc-a329-9447232442fe.go', '2024-06-21 16:22:19.275853+00', '2024-06-21 16:22:19.275853+00', NULL);
INSERT INTO "public"."events" VALUES ('b4313154-5d77-4213-ac0a-3c75fbe8d6d8', '8856e754-2c00-45da-98e3-8bdb7d0bc93f', 'Test10', '2024-06-27', 1000, 'bekasi', 'Sampokong', 0, 'Konser Tour Hindia', '/assets/images/abf7fb0e-e90e-4040-8feb-7b0e8bb0aa00.jpeg', '2024-06-21 16:55:58.543754+00', '2024-06-21 16:55:58.543754+00', NULL);
INSERT INTO "public"."events" VALUES ('ecf1402f-fa59-466e-9d74-df580362d514', 'cc98af8f-953c-4b2c-b7ef-767e1e3d21ba', 'Test10', '2024-06-26', 1000, 'surakarta', 'Sampokong', 0, 'Konser Tour Hindia', '/assets/images/0a03a12c-a15c-4145-b397-c8a764a53705.jpeg', '2024-06-21 16:26:32.444806+00', '2024-06-21 16:26:32.444806+00', NULL);
INSERT INTO "public"."events" VALUES ('20e2ffea-2948-4598-858c-515832a5710b', '8856e754-2c00-45da-98e3-8bdb7d0bc93f', 'Test10', '2024-06-20', 1000, 'Jakarta', 'betawi', 0, 'Konser Tour Hindia', '/assets/images/a4e1385c-0e2f-4b06-9945-2c25318bafdb.jpeg', '2024-06-21 17:21:50.248377+00', '2024-06-21 17:21:50.248377+00', NULL);

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS "public"."notifications";
CREATE TABLE "public"."notifications" (
  "notification_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" uuid,
  "type" text COLLATE "pg_catalog"."default",
  "message" text COLLATE "pg_catalog"."default",
  "is_read" bool,
  "created_at" timestamptz(6),
  "updated_at" timestamptz(6),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of notifications
-- ----------------------------
INSERT INTO "public"."notifications" VALUES ('932a36ad-71e1-44d8-89b3-09676d396a85', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.740602+00', '2024-06-23 12:50:51.740602+00', NULL);
INSERT INTO "public"."notifications" VALUES ('2c692f31-a201-40ad-8510-824001803184', '665e3bd5-8351-f89f-bea8-975c110266bb', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.752612+00', '2024-06-23 12:50:51.752612+00', NULL);
INSERT INTO "public"."notifications" VALUES ('0d8c7eb9-5374-42f9-933a-311fdf4ce491', '8095aa2c-df50-4f48-9ea3-fcdcd262ad41', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.755189+00', '2024-06-23 12:50:51.755189+00', NULL);
INSERT INTO "public"."notifications" VALUES ('69efb8c5-bd71-4bed-a78a-46a0d05e6763', '7cfb15ce-1b77-8ae3-45d0-b7b43a957aff', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.757441+00', '2024-06-23 12:50:51.757441+00', NULL);
INSERT INTO "public"."notifications" VALUES ('10ba9cb5-e9a0-4b1b-beff-ab3f2c6c58a0', 'b6eb5c2c-92db-5953-4811-31c63f063ba8', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.761218+00', '2024-06-23 12:50:51.761218+00', NULL);
INSERT INTO "public"."notifications" VALUES ('3f4cac5b-510f-46ea-9e0d-08519ec6e498', '53e03434-b055-43c9-977b-ff2a57c47ac1', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.763767+00', '2024-06-23 12:50:51.763767+00', NULL);
INSERT INTO "public"."notifications" VALUES ('39351352-0234-4434-befa-98d2742ab6a5', '10a3343f-6646-ada1-b88c-b8c71d459b5a', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.766284+00', '2024-06-23 12:50:51.766284+00', NULL);
INSERT INTO "public"."notifications" VALUES ('7b16f17d-bb5b-4eff-813d-01f3fb16d27f', '192f7a13-8439-44c0-bcbe-f59a2e835a0f', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.769865+00', '2024-06-23 12:50:51.769865+00', NULL);
INSERT INTO "public"."notifications" VALUES ('cadc110d-1af3-4b12-ab99-b031edb7d6d3', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.771973+00', '2024-06-23 12:50:51.771973+00', NULL);
INSERT INTO "public"."notifications" VALUES ('103f2e46-1f78-4ae8-a5eb-0cb71309b131', '6dbf3399-5d22-4d12-ba6c-e1d9b9a303b8', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.774033+00', '2024-06-23 12:50:51.774033+00', NULL);
INSERT INTO "public"."notifications" VALUES ('f8dde6c2-41b6-498d-88da-cb3c7a10bcfb', '21b243aa-9c8a-4cdd-8b13-3c815d583a50', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.776838+00', '2024-06-23 12:50:51.776838+00', NULL);
INSERT INTO "public"."notifications" VALUES ('f4b6a70e-c9e7-429c-bce0-6941756ea020', 'f3e634fc-0139-4bd7-9350-39bc08cf4b55', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.77928+00', '2024-06-23 12:50:51.77928+00', NULL);
INSERT INTO "public"."notifications" VALUES ('af82ec7f-0672-4f0c-9cae-182cffd72345', 'd55b9476-8853-4116-96d9-ed4056e699bc', 'Registration', 'Admin registration successful', 'f', '2024-06-23 12:50:51.78147+00', '2024-06-23 12:50:51.78147+00', NULL);
INSERT INTO "public"."notifications" VALUES ('fee20060-e811-497e-b289-5abc0ea88f89', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.471619+00', '2024-06-23 12:50:53.471619+00', NULL);
INSERT INTO "public"."notifications" VALUES ('12845be9-fb84-4363-a547-0210422dcedb', '665e3bd5-8351-f89f-bea8-975c110266bb', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.475012+00', '2024-06-23 12:50:53.475012+00', NULL);
INSERT INTO "public"."notifications" VALUES ('198d7ea6-adeb-4500-8008-7451f96bfb61', '8095aa2c-df50-4f48-9ea3-fcdcd262ad41', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.477014+00', '2024-06-23 12:50:53.477014+00', NULL);
INSERT INTO "public"."notifications" VALUES ('c473c8bf-db10-420d-a1ef-257472fe0b3a', '7cfb15ce-1b77-8ae3-45d0-b7b43a957aff', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.479237+00', '2024-06-23 12:50:53.479237+00', NULL);
INSERT INTO "public"."notifications" VALUES ('7334eda4-51ad-4c0c-8e65-0ba52257913b', 'b6eb5c2c-92db-5953-4811-31c63f063ba8', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.482236+00', '2024-06-23 12:50:53.482236+00', NULL);
INSERT INTO "public"."notifications" VALUES ('130eff5e-0805-4bf6-878c-d29391faad18', '53e03434-b055-43c9-977b-ff2a57c47ac1', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.484275+00', '2024-06-23 12:50:53.484275+00', NULL);
INSERT INTO "public"."notifications" VALUES ('000cbe68-ab54-4429-b65a-29e82651460c', '10a3343f-6646-ada1-b88c-b8c71d459b5a', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.486464+00', '2024-06-23 12:50:53.486464+00', NULL);
INSERT INTO "public"."notifications" VALUES ('0e8eb078-849d-4e9d-bf08-fae1e8d65d2f', '192f7a13-8439-44c0-bcbe-f59a2e835a0f', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.488998+00', '2024-06-23 12:50:53.488998+00', NULL);
INSERT INTO "public"."notifications" VALUES ('213cf32e-631e-4b4d-96ad-5d05bab647eb', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.491734+00', '2024-06-23 12:50:53.491734+00', NULL);
INSERT INTO "public"."notifications" VALUES ('60f60815-f886-4801-9547-3a0be85ffa54', '6dbf3399-5d22-4d12-ba6c-e1d9b9a303b8', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.493817+00', '2024-06-23 12:50:53.493817+00', NULL);
INSERT INTO "public"."notifications" VALUES ('516a5256-cb88-45bd-8486-34defc1909b8', '21b243aa-9c8a-4cdd-8b13-3c815d583a50', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.496271+00', '2024-06-23 12:50:53.496271+00', NULL);
INSERT INTO "public"."notifications" VALUES ('3ed36cc0-0f49-47a0-ac14-3d967e96afc4', 'd55b9476-8853-4116-96d9-ed4056e699bc', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.500259+00', '2024-06-23 12:50:53.500259+00', NULL);
INSERT INTO "public"."notifications" VALUES ('a33fdca5-5a46-4d46-acc8-6fb9dd60cde8', 'f3e634fc-0139-4bd7-9350-39bc08cf4b55', 'Registration', 'User registration successful', 'f', '2024-06-23 12:50:53.502828+00', '2024-06-23 12:50:53.502828+00', NULL);

-- ----------------------------
-- Table structure for schema_migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."schema_migrations";
CREATE TABLE "public"."schema_migrations" (
  "version" int8 NOT NULL,
  "dirty" bool NOT NULL
)
;

-- ----------------------------
-- Records of schema_migrations
-- ----------------------------
INSERT INTO "public"."schema_migrations" VALUES (20240606150048, 'f');

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS "public"."tickets";
CREATE TABLE "public"."tickets" (
  "tickets_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "transaction_id" uuid NOT NULL,
  "event_id" uuid NOT NULL,
  "code_qr" uuid DEFAULT gen_random_uuid(),
  "name_event" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "ticket_date" date NOT NULL,
  "qty" int4 NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of tickets
-- ----------------------------
INSERT INTO "public"."tickets" VALUES ('1d15e941-4c24-4620-9806-4e6433bbf905', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'd584c4cd-8b74-4dc1-9a31-cc5d6bd15f15', 'kemerdekaan', '2024-06-19', 2, '2024-06-18 20:25:56.662632+00', '2024-06-18 20:25:56.662632+00', NULL);
INSERT INTO "public"."tickets" VALUES ('15c919d0-f5fc-45cb-ba79-069085d88920', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '1d649517-d469-43bb-9085-14804a08b780', 'kemerdekaan', '2024-06-19', 2, '2024-06-18 20:28:34.532133+00', '2024-06-18 20:28:34.532133+00', NULL);
INSERT INTO "public"."tickets" VALUES ('2f8d4c66-7da8-4d1f-acec-258c9abb2c3e', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'fed9b119-38d4-4cb8-af98-24cbf5425957', 'kemerdekaan', '2024-06-19', 2, '2024-06-18 21:11:04.217844+00', '2024-06-18 21:11:04.217844+00', NULL);
INSERT INTO "public"."tickets" VALUES ('400ab1cc-fae4-4838-9e25-b80d6793a2dc', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'c73ad1fd-b9af-4b30-8504-9fc84987728f', 'kemerdekaan', '2024-06-19', 2, '2024-06-18 21:11:30.739214+00', '2024-06-18 21:11:30.739214+00', NULL);
INSERT INTO "public"."tickets" VALUES ('4d8b7a75-7b98-40d6-865f-c9f0501618f6', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '546adc3f-e27d-4a76-bd7b-19ae678de952', 'kemerdekaan', '2024-06-19', 2, '2024-06-18 21:15:29.62605+00', '2024-06-18 21:15:29.62605+00', NULL);
INSERT INTO "public"."tickets" VALUES ('f0c0a12f-587b-476c-8217-0ec5762285d4', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '7b48cb1d-f419-4040-a99a-8375967ea3d3', 'kemerdekaan', '2024-06-20', 2, '2024-06-20 14:43:41.321811+00', '2024-06-20 14:43:41.321811+00', NULL);
INSERT INTO "public"."tickets" VALUES ('cb00612a-eb1f-4df8-a628-c210310c1ba0', '3ad12d9a-dadd-4c2b-a0d6-fd97f58e14df', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'b917ebf8-fd06-4eca-8a96-221c4e9d78a7', 'kemerdekaan', '2024-06-20', 2, '2024-06-20 14:52:25.448664+00', '2024-06-20 14:52:25.448664+00', NULL);
INSERT INTO "public"."tickets" VALUES ('f6cc14a3-6864-444d-bb86-a7137d67d1f6', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '9672ed54-cae6-4a41-bb35-c077986dbfa3', 'kemerdekaan', '2024-06-21', 2, '2024-06-20 17:14:30.43674+00', '2024-06-20 17:14:30.43674+00', NULL);
INSERT INTO "public"."tickets" VALUES ('ace0c2a1-9b13-4aff-8ed0-4e1febf128b0', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '05714401-d630-456a-a0ff-bc10a703cff5', 'kemerdekaan', '2024-06-21', 2, '2024-06-21 06:11:09.421371+00', '2024-06-21 06:11:09.421371+00', NULL);
INSERT INTO "public"."tickets" VALUES ('ed0d9767-c644-4b79-a89b-fa66bb2a41cd', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '92f698ac-18ca-4003-b22e-44aec1d18e15', 'kemerdekaan', '2024-06-21', 2, '2024-06-21 06:11:20.282236+00', '2024-06-21 06:11:20.282236+00', NULL);
INSERT INTO "public"."tickets" VALUES ('869ee4eb-db58-4e1d-8f09-df8d054762bc', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'f864f5ba-ca90-41e5-b071-fd5aecd00346', 'kemerdekaan', '2024-06-21', 2, '2024-06-21 06:12:03.092122+00', '2024-06-21 06:12:03.092122+00', NULL);
INSERT INTO "public"."tickets" VALUES ('652fae27-2b35-4362-8ed6-2132315386fa', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'a7d117d7-f84c-40e5-ad91-34fbf6a31bed', 'kemerdekaan', '2024-06-21', 2, '2024-06-21 06:13:42.365629+00', '2024-06-21 06:13:42.365629+00', NULL);
INSERT INTO "public"."tickets" VALUES ('5b0d6a6b-d300-4e1c-94d7-4fa05b1a9d32', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'ed1f2891-e116-4a69-8a82-062e5093b141', 'kemerdekaan', '2024-06-21', 2, '2024-06-21 06:13:59.513935+00', '2024-06-21 06:13:59.513935+00', NULL);
INSERT INTO "public"."tickets" VALUES ('29286d4f-c5d7-498d-b4fa-c9163c44c92b', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', '94495a06-d2d2-461f-8d2c-05cf9b3094c0', 'kemerdekaan', '2024-06-21', 2, '2024-06-21 06:34:27.763255+00', '2024-06-21 06:34:27.763255+00', NULL);

-- ----------------------------
-- Table structure for transaction_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."transaction_details";
CREATE TABLE "public"."transaction_details" (
  "transaction_details_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "transaction_id" uuid NOT NULL,
  "event_id" uuid NOT NULL,
  "name_event" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "qty_event" int4 NOT NULL,
  "price" int8 NOT NULL,
  "ticket_date" date NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of transaction_details
-- ----------------------------
INSERT INTO "public"."transaction_details" VALUES ('1af653de-1fac-41b5-be92-bf9d920ef4d9', 'f831313d-34d4-450c-8682-6f519baa18cd', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:55:06.140528+00', '2024-06-15 01:55:06.140528+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('400f21f7-f3a5-459c-ba14-fe04149500c3', '6294e829-7a82-4a5b-8dcd-554238dbc7d9', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:55:45.415703+00', '2024-06-15 01:55:45.415703+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('7126b0e6-a5eb-4fb3-a1e4-7e7ebd92ef50', '0025711f-41d4-4784-a19d-056e8144cb5f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:56:17.955365+00', '2024-06-15 01:56:17.955365+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('5f3df03e-642c-4d25-b697-1772a220acfb', '30eec780-9464-4a79-b613-1aae762cd043', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:31.686896+00', '2024-06-15 01:58:31.686896+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('54a85824-026d-4a9c-86fd-65f527da9292', 'a1c4b9cd-1bae-4ca4-97e8-35ec89c68ae4', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:33.3325+00', '2024-06-15 01:58:33.3325+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('8a5fd58e-cb55-47ae-bc9d-9435d98eca86', 'a7f91426-38e3-491e-b960-c6476dd07a80', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:34.643753+00', '2024-06-15 01:58:34.643753+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('6288efd7-0391-427e-af31-03b02ffad063', '181e4185-d432-4f9a-a55b-e81694994c66', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:41.430725+00', '2024-06-15 01:58:41.430725+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('6f9b7c5d-28bf-4821-95fc-346438cfe7b8', 'bf51d940-0fb2-4f63-b430-6aa8573f3392', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:43.479239+00', '2024-06-15 01:58:43.479239+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('df115019-e435-4011-b728-3a01bf4940bb', '0385585c-bb3e-4c63-9e78-13256f8e19ce', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:47.38469+00', '2024-06-15 01:58:47.38469+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('2886907e-5dfa-4417-ad3f-02ae5a40b12d', '9059b456-b81e-43f0-947d-22133a9f315f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:48.439627+00', '2024-06-15 01:58:48.439627+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('fad0fefe-92ce-4ebd-a0d4-b703db82000d', '255aa2e7-ef7e-481f-9e8f-713ee13765c6', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:49.647538+00', '2024-06-15 01:58:49.647538+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('602526f0-c200-4cf6-9557-b91442c665ee', '775eed0b-737a-4aa0-8fd4-7e633a8c020e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:53.881153+00', '2024-06-15 01:58:53.881153+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('b4c1141e-4f84-4910-a8a3-8cc3b216a7e6', 'd64a2648-6308-432e-9875-9b647ee26169', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:55.249967+00', '2024-06-15 01:58:55.249967+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('65507b99-d54e-43ff-ab84-c0d83114fdb2', 'b863a10c-8ea6-4999-94d6-e6a980bc45b6', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:56.392972+00', '2024-06-15 01:58:56.392972+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e1bc3880-cfc4-46da-a4d2-c5c9b5e6c19c', '5566a415-3b95-4fbf-803b-71d487c38fa9', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:57.523849+00', '2024-06-15 01:58:57.523849+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('1580791e-dfc9-4448-a6f0-466edd5785f2', '68162609-f0b9-4f0d-950f-c23c9ecd9788', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:58.645404+00', '2024-06-15 01:58:58.645404+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('5ce9602a-911a-4245-92b3-0294dda4e9c6', 'd269cb9c-ec92-466e-b6f1-93448260ef3a', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 01:58:59.986319+00', '2024-06-15 01:58:59.986319+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('c7ccb0b6-3e01-41e4-8865-d766e861c3a6', 'c8388a27-a85c-42df-b6ea-b842f312ebdc', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:09:02.905373+00', '2024-06-15 02:09:02.905373+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('75ebd4d2-f865-4c05-a7ac-49bac0baa4e7', '35177354-e7ad-4b76-85bc-a647fb6f3017', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:11:25.450797+00', '2024-06-15 02:11:25.450797+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('845f95ee-963f-40d5-a607-a1e176fcd662', 'e573b0b8-6358-47ea-8b28-8de70e5d5656', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:11:27.270183+00', '2024-06-15 02:11:27.270183+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f225bb31-ee0e-4bd9-bf86-b1af98bad99e', 'd1a0d11c-77c2-4c08-b5b9-441cb627a92e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:11:34.900734+00', '2024-06-15 02:11:34.900734+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('47e04a85-2b74-4ef6-b898-3b4f01af03aa', 'ab67341d-1eab-40e6-8658-616deb75a3cc', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:11:49.538213+00', '2024-06-15 02:11:49.538213+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('1b77fea8-fe02-4a6b-9eea-42c62917b826', '94cc026c-97c2-4d8b-9cab-29d13388a5b4', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:11:50.810301+00', '2024-06-15 02:11:50.810301+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f68b191b-9cf8-4aec-92ad-16a22943dd3c', '6ca3e957-bee5-42b2-9af7-c2748d48a363', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:20:09.309186+00', '2024-06-15 02:20:09.309186+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('c6d2f3d7-3b04-4c57-aef2-6422d7cc5673', '0f79839b-855a-4d7d-b664-b418620f8121', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:20:11.111981+00', '2024-06-15 02:20:11.111981+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('16ee7b5f-e9f3-4e07-ba48-7e63b0b793a3', '2a9405bf-0fb5-44d7-bbb9-db607480c614', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:20:16.379123+00', '2024-06-15 02:20:16.379123+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('ce126fa3-a768-4048-9329-9a6b916cbf68', '9a1664e8-9c6d-42d9-baba-4a50f88ac303', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:28:05.810776+00', '2024-06-15 02:28:05.810776+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('39029945-84ba-40e4-8cc2-6f8fb8d08d94', 'fc4db76b-6d2a-4d95-bc51-e146b55ba59b', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:28:07.351894+00', '2024-06-15 02:28:07.351894+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('db98de44-ef1e-4eb4-9078-7998c21427dc', '44bd2f0a-7fc8-48f1-855a-129f777de11f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:28:08.606028+00', '2024-06-15 02:28:08.606028+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('d5b911ab-f664-4054-9a49-eaa50043b8f7', 'e6df0924-03b6-4eba-b378-e77473e98c97', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:28:25.12078+00', '2024-06-15 02:28:25.12078+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('7919f731-486c-46db-aefa-5a04990ebb5e', '5bf13b2f-69c2-44ba-abc6-f05b577ab6be', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:28:28.588072+00', '2024-06-15 02:28:28.588072+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('aa23bc37-e00b-4112-af57-d48053283790', 'af641b9c-3653-417e-a44a-cd1650db2076', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:34:53.241876+00', '2024-06-15 02:34:53.241876+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('2c320740-b20d-4d63-b8da-00a72c4544b5', '8e4a707a-2d2b-4991-a077-a6fa8f309d6e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 483, 48300000, '2003-07-17', '2024-06-15 02:36:14.131881+00', '2024-06-15 02:36:14.131881+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f1b2d5d7-5ce5-46ae-832d-d1b6b0655e59', '2b538f4d-e5cb-4a5c-afac-bcd01962daaa', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-15 17:55:30.26099+00', '2024-06-15 17:55:30.26099+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('76d12229-4b08-43ec-ba86-33085b6276f1', '98b5954f-d2fc-493e-a523-4efd09316c83', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:14:04.161513+00', '2024-06-16 14:14:04.161513+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3aae9d00-3999-460e-8d2d-cc1b8097eea6', '6d600b25-8c49-4b8b-b6df-4c648949f89b', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:14:50.40965+00', '2024-06-16 14:14:50.40965+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e6c843e3-3f4b-47ad-a6b3-20e8294fb1dd', '330d7df9-b540-4bc3-96b8-05117e88796a', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:15:26.21441+00', '2024-06-16 14:15:26.21441+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('0b97cebd-b71f-43d8-ad21-dac143d410ef', '53e4cded-fb75-4767-8e0f-9bd5b1854b47', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:15:53.90217+00', '2024-06-16 14:15:53.90217+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('7f9a94a4-910d-4c76-b13c-0d2471ebf46c', 'c287f6eb-162a-41ee-9190-9b77c0450724', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:21:54.509427+00', '2024-06-16 14:21:54.509427+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e0a07dc2-40b1-4cc2-a295-cf515b877dd1', 'a832fb92-3f71-4e20-a87c-27e1c692fc74', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:22:17.079123+00', '2024-06-16 14:22:17.079123+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('d21dbee4-23f4-4e0e-8f3b-981fbd0e72a5', '78ee54b6-5a00-415f-b9c9-3951b9dbd724', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:26:16.759452+00', '2024-06-16 14:26:16.759452+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3515e9b7-0561-4c31-bbcb-fe259dba53cc', '0b8dcd35-abc0-4944-80ab-7e8f423ebc04', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:30:15.182145+00', '2024-06-16 14:30:15.182145+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f96240d3-84a7-43d9-b08e-6e79c3d75d30', '724a10cf-785c-4bfe-b12b-70a6fb42ebb5', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:31:27.730069+00', '2024-06-16 14:31:27.730069+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('dd752fa6-3fa0-404b-9c44-4732e7afa31e', 'f244b590-6f6c-4bcf-a606-b4121c01fabc', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:31:28.80693+00', '2024-06-16 14:31:28.80693+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('c92ed808-f412-4cef-9acf-a97ba7e64a28', '3001ecc4-018d-4b1b-90b5-428bb119cd39', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:31:29.991643+00', '2024-06-16 14:31:29.991643+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('9b422b60-f0b1-4d63-bb08-28f28d3340c7', '9df1a6ec-2913-4149-bfee-d8d82f51c4ae', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 14:31:31.161561+00', '2024-06-16 14:31:31.161561+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('16ea1b76-b053-4cf9-a8c2-32be897ba7e9', '9980d913-1ab0-4c20-9190-c10a3bc5ae62', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 17:51:25.937574+00', '2024-06-16 17:51:25.937574+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('060fecfe-82e9-425e-bfbe-4b1ac0ed508a', '3705f45f-e776-4c30-8599-d5ed293c76b8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:03:14.108569+00', '2024-06-16 18:03:14.108569+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('affb86d6-d336-44c5-a154-7335b17fc3b6', '1dcb1464-9de2-41c9-bce6-f9dc19d84946', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:03:52.40558+00', '2024-06-16 18:03:52.40558+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('8aca2f85-bfac-4877-9c2f-739e89b4651d', '807f5761-4fef-4a5f-a079-616d9bce274d', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:04:26.534807+00', '2024-06-16 18:04:26.534807+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('1440908c-c11a-428b-9c9f-e2c220fcf1f0', '4417adb6-0da9-405b-abb0-ab5af4f6fba2', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:16:25.53219+00', '2024-06-16 18:16:25.53219+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('688cb424-1564-49e2-9ffd-227840d20e75', '7f7ca6e9-301d-4b95-900c-a12ed18ab570', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:16:43.054974+00', '2024-06-16 18:16:43.054974+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3e65d9e2-a1e6-4630-aeaa-299084f26d99', 'f86fdd73-ad48-4f22-9640-e393d1724f82', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:17:26.058196+00', '2024-06-16 18:17:26.058196+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3e4c354d-fbf6-4523-aba2-121380517b4f', 'f088f7fb-0756-4034-be68-c0ffaf84a945', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:28:38.428924+00', '2024-06-16 18:28:38.428924+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('d891aeab-27c5-4c12-8c86-43578d5feedf', 'f7eba9f9-2910-4af0-a35e-222cf28d656e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:30:10.513141+00', '2024-06-16 18:30:10.513141+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('fba22715-452f-44fe-aa32-682069f6552a', '6fcc7e04-3aa5-4f83-a132-42272d937b2a', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:30:32.256337+00', '2024-06-16 18:30:32.256337+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('67257d7e-b102-408d-80a3-8c9934a2dd77', 'f62a2da2-e287-4db6-8c35-0cb7bdeda638', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:31:01.700104+00', '2024-06-16 18:31:01.700104+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e3578e1e-87eb-4a01-9094-f93de9f17b09', '79e82e7c-1631-406d-9e50-36ffc95fc80c', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:33:34.578626+00', '2024-06-16 18:33:34.578626+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('5dfac387-935f-42e9-baab-7911525e405f', '139c7b47-eadc-41e0-a030-3fae8eb0312d', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:34:07.523479+00', '2024-06-16 18:34:07.523479+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('966f35e1-258f-4e12-9621-fa973f4daf66', '1749082d-dcc7-4c7e-9a4b-d385adf25151', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:34:52.789854+00', '2024-06-16 18:34:52.789854+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('5a831a17-55ac-4495-a505-e8a88c7bcf3d', 'eed6ebc3-7a81-4ad0-8610-a76361ab8e45', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:35:18.297517+00', '2024-06-16 18:35:18.297517+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('2a7574fc-fcc3-4429-96e7-19a0d2365798', 'def982c3-90cb-4f9a-80f7-0f74101c5795', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:36:26.985419+00', '2024-06-16 18:36:26.985419+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('a162c7a0-53e0-41a4-a58b-0b2dde2c7407', 'c3a26e83-f45e-45b9-8087-c5c95fcbda02', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:37:18.839233+00', '2024-06-16 18:37:18.839233+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3d297696-4a8b-46d7-bd34-c5e358366007', 'd8ecae44-a81d-497b-a147-510d7558dc8f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:37:38.758563+00', '2024-06-16 18:37:38.758563+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('0cda6c2a-b260-4f53-a2c2-98efe1ca0025', '8c2c1733-e695-4381-9bba-d5bad1f8d75e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:42:10.872429+00', '2024-06-16 18:42:10.872429+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('10d461db-7f8a-466e-ba7b-4bdcd8526f23', 'e1a8b765-3708-4d9f-96f8-0e932963e573', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 18:43:03.024533+00', '2024-06-16 18:43:03.024533+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('57ae27fd-4b12-4e53-b5b9-130e1724beb7', 'c9834676-34e2-4328-937b-3a7e30c49b9f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 19:53:57.617549+00', '2024-06-16 19:53:57.617549+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e438928b-c569-4265-a631-60ad0b2def92', 'e31c0f0d-79a1-4023-80e0-4625b0d4c5f4', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 20:44:07.970669+00', '2024-06-16 20:44:07.970669+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f998beb7-eaf8-4b3c-aae3-67718bd14fd3', '77a242f8-46ba-4c64-bd3c-9eadf6dbf698', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 20:50:39.093795+00', '2024-06-16 20:50:39.093795+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('178be1ce-64c9-4540-8439-35512e56fa59', '5582b392-571f-4134-bdde-b91db12729a9', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 21:12:52.42135+00', '2024-06-16 21:12:52.42135+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('6973c4be-231b-4ebb-815d-f84f93471e18', 'b10afdcd-5691-40c9-a73c-fe164c2783cc', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 21:13:24.147539+00', '2024-06-16 21:13:24.147539+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('89276d82-5a18-4644-812e-3e0ee832b0c8', 'c71693ed-33e5-4edd-b3b1-fce8be16ecd0', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-16 21:14:39.148373+00', '2024-06-16 21:14:39.148373+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('1255c52e-11a1-4a6e-9f02-f0884e3a1199', '73d5f389-c588-423d-b4a0-3e56f331bed0', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 16:52:56.457213+00', '2024-06-17 16:52:56.457213+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3e6ef0ac-247d-4444-808e-229bb6064107', '63379bc2-9a5c-429a-8505-df0fcf83a953', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 17:00:55.498459+00', '2024-06-17 17:00:55.498459+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('30a751ee-e648-490e-acc7-270445150348', '2ab39286-0746-4321-8c74-b284d5939823', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 17:01:45.533712+00', '2024-06-17 17:01:45.533712+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('7a769df1-2afb-4441-b1a3-3573195af5a9', '80d2215c-8b54-4e41-b93b-a2942a18c4b4', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 17:04:04.588944+00', '2024-06-17 17:04:04.588944+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('9ae42757-8e73-4ed3-b7d0-f15d72680b3f', 'c9a3c058-2c8f-4989-8b26-f46a73dca016', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 17:55:16.75818+00', '2024-06-17 17:55:16.75818+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e92266a7-0354-4694-b16e-41f854e238cd', '41aed409-7b9d-4a48-b639-edb602680b7e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 17:56:20.543878+00', '2024-06-17 17:56:20.543878+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('91c989ae-d074-4b93-856b-45f3d2e0af7b', 'd0023607-9215-486a-80f4-62775e521e9d', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 18:16:36.971993+00', '2024-06-17 18:16:36.971993+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('ec2319e4-b9ce-4dfb-8232-e3340629fea8', 'f6748771-b2cb-466b-9d06-216cece69fd3', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 18:18:14.071904+00', '2024-06-17 18:18:14.071904+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('532c7336-ae4d-4869-8531-9e3ff259474d', '730dd137-5012-4a31-b461-c095cafe5d18', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 18:21:02.203801+00', '2024-06-17 18:21:02.203801+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3db05521-73ef-4d64-9aeb-c09dba1c3600', '2c2b836d-8e18-4733-ae01-baf8b0362451', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 18:22:02.354575+00', '2024-06-17 18:22:02.354575+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('a4c63250-dd9a-48ff-94b5-8fcacaa1533b', 'd1de9856-ad5d-4264-9716-db23b11268d2', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 19:40:03.617812+00', '2024-06-17 19:40:03.617812+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('291063d1-5532-4cd2-ba77-b835afd6ff60', '2b703897-b4be-47c8-a729-e053da7cbdcc', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-17 19:52:50.181444+00', '2024-06-17 19:52:50.181444+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('a8490ba5-3fcd-4a03-a353-4bd937e021f8', '6b1deef7-7723-46fc-b9a4-7906c4467481', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 05:45:12.681547+00', '2024-06-18 05:45:12.681547+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('af33520c-3b64-4e06-b4d9-c61aaa2f431c', '9de1c5d6-f1cb-47e4-8e33-8a39e089db9d', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 05:59:37.211407+00', '2024-06-18 05:59:37.211407+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f7c05231-610e-428a-92e4-1dfcc5ab9895', '419e9d6c-38a9-4dcd-9eeb-9d38fa1df018', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 05:59:55.347422+00', '2024-06-18 05:59:55.347422+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('613e1690-e9c8-46fd-ab01-4ac60d384bc6', 'd5b00e27-c279-4eaa-a327-e8e74ae50ab0', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 05:59:57.408221+00', '2024-06-18 05:59:57.408221+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('3d763e1f-4216-4593-8413-b77a9690b2f8', '9605a4aa-3612-489c-b058-1591ba6610ee', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 06:49:53.249326+00', '2024-06-18 06:49:53.249326+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('139e8e73-2e6c-4bb8-819d-df72049c3d9b', '40538e2d-180e-44ea-8807-b4c8944ac699', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 06:51:01.748411+00', '2024-06-18 06:51:01.748411+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('0a696e3d-682a-4d8f-bf33-4e4f0ac6c857', '29fcb035-8d2a-40f4-96f5-c17b0e53fe34', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 16:49:43.424439+00', '2024-06-18 16:49:43.424439+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('48b8bba2-3287-42e8-b920-c26fcc0f303b', 'ca02359e-cb94-4d15-9ed8-402bfe2f4180', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 19:52:37.867133+00', '2024-06-18 19:52:37.867133+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('83ea341b-ae09-4242-90db-bdeae517e308', 'b5542e81-9b1c-48d4-838a-7ae303f12775', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 20:18:26.752244+00', '2024-06-18 20:18:26.752244+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('4c199bf7-62df-4f6a-ab6e-efc39f5dbe14', '15726a5f-20ce-4f88-9429-b160f28ab356', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-18 21:16:04.763841+00', '2024-06-18 21:16:04.763841+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('85435193-04b8-4ede-9982-0dc6ee2912c1', '982896d1-e6e3-4387-ad8a-09bbcd18ddff', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 14:45:03.782485+00', '2024-06-20 14:45:03.782485+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('afeaa9f5-ba61-4213-88ca-017751a2f167', '3ad12d9a-dadd-4c2b-a0d6-fd97f58e14df', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 14:47:38.577908+00', '2024-06-20 14:47:38.577908+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('6f1bb71b-3093-40ff-99d4-fc5c231fe6d4', '8fceb94b-f1be-486e-8c0d-15c3b8e7e78e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 14:47:53.540461+00', '2024-06-20 14:47:53.540461+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('d2a44703-e878-43a4-8ab7-0fcebd689b3c', 'b4072cf3-00f8-4175-8856-3214c076cf3e', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 17:07:20.160595+00', '2024-06-20 17:07:20.160595+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('b0f2f94b-74e0-4a1d-aa9b-2ce6e278c9e5', '14cdd615-c0d9-46c2-b0c4-c631ed8ac46f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 17:12:41.539237+00', '2024-06-20 17:12:41.539237+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('f917e10b-e2f2-43f6-882f-6aaf4caafe4c', 'cdbc3b08-d628-4992-b9fb-f1e32acc21f8', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 17:12:51.192908+00', '2024-06-20 17:12:51.192908+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e003d0f4-b9da-447f-82e7-0ed09e1ebf32', '1dba277b-78f8-4e5f-8825-1e1ab75e3854', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 18:05:19.516457+00', '2024-06-20 18:05:19.516457+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('9b908d10-fa65-4a9c-8c85-aedce9e11887', 'b33997f1-7e68-45ef-bca7-fbb174d8ac39', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 18:05:51.166637+00', '2024-06-20 18:05:51.166637+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('cd24c073-1be2-4565-9618-7f72f2cfeb2d', 'a9af7a10-96a6-46e8-8eb1-a86d949fb003', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-20 18:06:23.775312+00', '2024-06-20 18:06:23.775312+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('e2d6f412-7299-461e-a8be-0a9d6ee6819b', '3bc62cbd-3669-4f57-adee-c708e5729c1b', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 08:33:06.784087+00', '2024-06-21 08:33:06.784087+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('a70c2838-3fe1-4fb5-b738-00104352cc39', '4af5a117-df8c-4bee-a89c-f4dad606614f', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 08:33:18.985748+00', '2024-06-21 08:33:18.985748+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('cdb0ee54-ad35-41c3-a64f-562a35941a7d', '35fabb96-60a5-468a-9f98-59a19eef7a7a', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 08:35:43.905905+00', '2024-06-21 08:35:43.905905+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('01bbbb27-c397-4cf8-8d68-6cb9c7605b80', '136e43ae-692d-422b-9e45-e7ed54ea7fe1', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 08:36:37.845001+00', '2024-06-21 08:36:37.845001+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('c99a7bd6-29f8-4d35-a38f-7a80e6eb8871', '071b815a-291a-4bcc-bfaf-44994e5538d5', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 08:36:50.770305+00', '2024-06-21 08:36:50.770305+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('82a00f94-34c3-4d16-978c-7389b408ef6e', '38e6598e-7503-462a-92c1-a726ed110612', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 12:34:16.707649+00', '2024-06-21 12:34:16.707649+00', NULL);
INSERT INTO "public"."transaction_details" VALUES ('c2c2aa39-18c6-4a41-9b09-3f178ab96728', 'e880887f-4bda-4e24-9118-fc2109a99801', '080c9d69-e9f2-63f9-0412-28b10b5b2dfd', 'kemerdekaan', 2, 200000, '2003-07-17', '2024-06-21 12:39:59.269112+00', '2024-06-21 12:39:59.269112+00', NULL);

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS "public"."transactions";
CREATE TABLE "public"."transactions" (
  "transactions_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "cart_id" varchar(255) COLLATE "pg_catalog"."default",
  "user_id" varchar(255) COLLATE "pg_catalog"."default",
  "fullname_user" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "trx_date" timestamp(0) NOT NULL,
  "payment" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "payment_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "amount" int8 NOT NULL,
  "status" bool DEFAULT false,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO "public"."transactions" VALUES ('4afc11e1-4a12-4bee-85ea-511ed7fd2279', '7807e6d7-367d-40c1-956d-1441d18e78de', 'e13aef16-68c0-4448-a5d9-a9f818927fb7', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-07 18:05:21.796707+00', '2024-06-07 18:05:21.796707+00', NULL);
INSERT INTO "public"."transactions" VALUES ('bd443806-75a7-424e-b8cd-bcddeada31af', 'cdd6625c-c4c3-4ac3-9149-7c536cc85125', '0c58eddd-3df3-432c-9791-b5d4f558f181', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:22:31.663434+00', '2024-06-08 17:22:31.663434+00', NULL);
INSERT INTO "public"."transactions" VALUES ('912a25b8-3ea8-418c-a01e-ea502133024a', '7317143b-cb1b-4b93-94fc-ae35107b8ca1', '9f280296-a3ba-46a1-8609-0322f73ce243', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:24:26.951067+00', '2024-06-08 17:24:26.951067+00', NULL);
INSERT INTO "public"."transactions" VALUES ('12b0e2bf-ce5c-489b-93b1-d0bd7559b1f4', '52998a83-6287-4282-998b-b18f38999f65', '4c6c6ce1-0133-4893-a5b4-d5920fc46dc7', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:27:34.211328+00', '2024-06-08 17:27:34.211328+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1e48f20d-07c7-48cc-92b9-e82b9fcd16ff', '771d423f-f21a-4a33-89d9-b10e970d79b9', '1415947b-8d54-4fce-943e-d0bacca87267', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:27:58.784113+00', '2024-06-08 17:27:58.784113+00', NULL);
INSERT INTO "public"."transactions" VALUES ('cda570ff-50cc-4558-b962-bfdfc084584e', '4afc8a04-d189-4992-a4af-d2621cdcad86', '9ef4a8fc-13ea-4f29-8926-c69c74df9720', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:28:32.243726+00', '2024-06-08 17:28:32.243726+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5c1ffed7-af26-4bef-b8cd-cde0f92482b4', 'cda570ff-50cc-4558-b962-bfdfc084584e', 'cda570ff-50cc-4558-b962-bfdfc0845843', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:31:16.54153+00', '2024-06-08 17:31:16.54153+00', NULL);
INSERT INTO "public"."transactions" VALUES ('13495d7f-7bbb-4408-9f0b-1a51ccfced1f', 'cda570ff-50cc-4558-b962-bfdfc084584e', 'cda570ff-50cc-4558-b962-bfdfc084584e', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:34:21.262976+00', '2024-06-08 17:34:21.262976+00', NULL);
INSERT INTO "public"."transactions" VALUES ('63bfb44a-1a0e-4187-95ea-5f95565f80af', 'cda570ff-50cc-4558-b962-bfdfc0845842', 'cda570ff-50cc-4558-b962-bfdfc0845843', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:34:28.098184+00', '2024-06-08 17:34:28.098184+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6b8ab684-8132-4d93-a89c-626f63731f06', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-08 17:37:13.955009+00', '2024-06-08 17:37:13.955009+00', NULL);
INSERT INTO "public"."transactions" VALUES ('334daf00-fa3a-42f1-83d8-a2948f2d91cd', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 14:22:55.423888+00', '2024-06-09 14:22:55.423888+00', NULL);
INSERT INTO "public"."transactions" VALUES ('a3d8065f-0d8d-41b9-b7e4-26ce4f3f51df', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 14:23:08.623471+00', '2024-06-09 14:23:08.623471+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0a796d22-5716-40b1-a944-dcca35d70196', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 14:28:49.908064+00', '2024-06-09 14:28:49.908064+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6ab92744-5b2f-4470-bc82-cc9b3b175bc2', '', '', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 16:50:45.543583+00', '2024-06-09 16:50:45.543583+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d845350c-61fb-45be-8c33-36768ed7f1af', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:51:04.201262+00', '2024-06-09 16:51:04.201262+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5d2b12d9-98c5-4b46-9c7d-c085693093ff', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:52:07.012759+00', '2024-06-09 16:52:07.012759+00', NULL);
INSERT INTO "public"."transactions" VALUES ('ad1231d5-76a2-4f91-8ffd-1dc5790f4c3a', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:52:08.877651+00', '2024-06-09 16:52:08.877651+00', NULL);
INSERT INTO "public"."transactions" VALUES ('eb100bd3-a01b-4a3a-aabc-64b227fd51ba', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:52:10.025571+00', '2024-06-09 16:52:10.025571+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1ae92205-af63-4589-8a88-d8c2fa19c130', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:52:10.996434+00', '2024-06-09 16:52:10.996434+00', NULL);
INSERT INTO "public"."transactions" VALUES ('399488c3-7d0f-4a95-af8c-d97f3f6998f0', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:52:11.831034+00', '2024-06-09 16:52:11.831034+00', NULL);
INSERT INTO "public"."transactions" VALUES ('63af587d-502d-45c9-827a-2ee8dedfd628', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 16:52:12.577908+00', '2024-06-09 16:52:12.577908+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c4900bad-da50-406c-a48f-06d955a3debe', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:32:51.248694+00', '2024-06-09 17:32:51.248694+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f78098c5-27e3-4199-9d60-41b79171282e', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:33:13.258286+00', '2024-06-09 17:33:13.258286+00', NULL);
INSERT INTO "public"."transactions" VALUES ('63c984d3-a9ae-4f1e-a8e4-0285b9488c77', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:39:21.908308+00', '2024-06-09 17:39:21.908308+00', NULL);
INSERT INTO "public"."transactions" VALUES ('cc3f7757-4f4f-4ecf-b40c-2eff00d2f1d1', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:39:36.538591+00', '2024-06-09 17:39:36.538591+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b3fc3ccd-eb9d-40d0-8042-e853a7ea2b15', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:49:53.739134+00', '2024-06-09 17:49:53.739134+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d1a0e33d-3935-4b7e-bcc5-47de935ab549', '', '', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:49:59.020387+00', '2024-06-09 17:49:59.020387+00', NULL);
INSERT INTO "public"."transactions" VALUES ('47290eaf-e11a-4c5b-aaaf-3e081ec5f618', '', '', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:50:35.132434+00', '2024-06-09 17:50:35.132434+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3390d8e4-3857-42c7-9ad4-044fdbab2e4e', 'sss', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:55:59.410972+00', '2024-06-09 17:55:59.410972+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6c4935c0-463c-47d2-ae95-d2d443ba6b83', 'sss', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 17:59:32.530504+00', '2024-06-09 17:59:32.530504+00', NULL);
INSERT INTO "public"."transactions" VALUES ('8ef23a98-9a20-4927-b508-e8b4c396d80a', 'sss', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:07:19.83873+00', '2024-06-09 18:07:19.83873+00', NULL);
INSERT INTO "public"."transactions" VALUES ('667c8ec7-6fcf-4f9b-9676-94361a7cd5a8', '', '', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:07:37.948182+00', '2024-06-09 18:07:37.948182+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0ecf6b53-1e38-4435-acfb-ca94ef8a06dc', 'sss', 'hgfdsa', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:07:53.314915+00', '2024-06-09 18:07:53.314915+00', NULL);
INSERT INTO "public"."transactions" VALUES ('4f841514-b32f-4985-98ab-0cecd7cc4b05', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:08:36.776386+00', '2024-06-09 18:08:36.776386+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6268cb47-ddaf-4ca4-af1e-cc47f5e2cb11', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:08:45.204749+00', '2024-06-09 18:08:45.204749+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b8272764-eb95-4644-bc7e-b3070adcf143', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:09:03.003948+00', '2024-06-09 18:09:03.003948+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e7fc0326-c6bf-43e6-8c5b-8ac17ce0925c', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:09:04.000694+00', '2024-06-09 18:09:04.000694+00', NULL);
INSERT INTO "public"."transactions" VALUES ('427c248a-a655-4786-b319-ff834a30cf4e', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:09:04.50721+00', '2024-06-09 18:09:04.50721+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0353897d-2987-4e9f-887c-17e10db0d404', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:09:04.998056+00', '2024-06-09 18:09:04.998056+00', NULL);
INSERT INTO "public"."transactions" VALUES ('87555617-1b75-4622-9d3c-c3aa96c5f34b', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:09:05.440391+00', '2024-06-09 18:09:05.440391+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b9fb75f8-85c4-4fb8-aaf9-dad08014040b', '', '', '', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-09 18:09:05.944012+00', '2024-06-09 18:09:05.944012+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6a0c6d66-c33a-475a-85a3-893ec55674a4', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:18:16.306043+00', '2024-06-09 18:18:16.306043+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f7177a36-ef4d-497f-98cc-a7aeb3f5d4c1', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:28:28.636262+00', '2024-06-09 18:28:28.636262+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d1650de0-0903-45f0-bf3b-228c1424ef42', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:28:55.153558+00', '2024-06-09 18:28:55.153558+00', NULL);
INSERT INTO "public"."transactions" VALUES ('24e8c83e-5f09-40d2-a502-67088f82d9d4', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:29:01.72027+00', '2024-06-09 18:29:01.72027+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5c4624bc-492d-4420-978b-ccac8cd4e713', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:35:12.117833+00', '2024-06-09 18:35:12.117833+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2a977c0e-698e-4c2e-83ae-9997224f1ad9', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:38:16.298447+00', '2024-06-09 18:38:16.298447+00', NULL);
INSERT INTO "public"."transactions" VALUES ('06f497a0-e79e-4f2d-a0f3-94a11a813cc2', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:38:20.033265+00', '2024-06-09 18:38:20.033265+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5a8d088b-3ec5-4c69-9c59-b7b7c5ed71ab', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:40:21.201723+00', '2024-06-09 18:40:21.201723+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b92482a4-619c-4ec6-a3b8-0687e2783fcf', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:40:22.471073+00', '2024-06-09 18:40:22.471073+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0c171531-a2a7-4452-afd4-0e7d6e50d462', '', '', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:40:28.345024+00', '2024-06-09 18:40:28.345024+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2d18356a-538e-47c7-8cf4-c01cee6b6e9b', '', '', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:45:31.920287+00', '2024-06-09 18:45:31.920287+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5ed3a67b-36ec-4306-9224-a355a0e72941', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 't', '2024-06-09 18:46:51.626454+00', '2024-06-09 18:46:51.626454+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5af3d6ca-7b43-4bd4-b9c3-2843a3e32538', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:30:33.235391+00', '2024-06-10 12:30:33.235391+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1d4fe4da-f931-44a5-9276-11cb08ab4125', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:32:57.169159+00', '2024-06-10 12:32:57.169159+00', NULL);
INSERT INTO "public"."transactions" VALUES ('cc55b61a-ee4b-4ff3-9eed-22021a7feda9', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:34:11.5814+00', '2024-06-10 12:34:11.5814+00', NULL);
INSERT INTO "public"."transactions" VALUES ('beb74190-31ec-427e-a697-cfdbf97099ea', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:34:13.419752+00', '2024-06-10 12:34:13.419752+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0bafcb8d-22ec-4014-b386-31a1162d7abd', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:36:11.422688+00', '2024-06-10 12:36:11.422688+00', NULL);
INSERT INTO "public"."transactions" VALUES ('51536174-4b1f-4ba5-a840-9ea0612834e4', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:36:15.293324+00', '2024-06-10 12:36:15.293324+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b6a6955b-3eec-464a-868f-8b7a1451cbc7', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:36:21.976103+00', '2024-06-10 12:36:21.976103+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2b91b1c3-6f50-464e-a02b-87f6e23ac099', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:46:09.776701+00', '2024-06-10 12:46:09.776701+00', NULL);
INSERT INTO "public"."transactions" VALUES ('90f79211-17dc-4a4f-a0ba-09d07c223282', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:52:31.514873+00', '2024-06-10 12:52:31.514873+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c532e0eb-16e6-49dd-bd88-4719ef54b13c', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:52:35.167791+00', '2024-06-10 12:52:35.167791+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c0ff7cec-39fb-469e-ae21-5e08553af77b', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:53:39.387777+00', '2024-06-10 12:53:39.387777+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c4b240c9-e9b9-48d9-9ffe-855de6e54859', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 12:57:31.890491+00', '2024-06-10 12:57:31.890491+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b74fd428-3ea7-46ea-86b0-c9f43054da7a', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 13:06:26.727202+00', '2024-06-10 13:06:26.727202+00', NULL);
INSERT INTO "public"."transactions" VALUES ('79be8658-412f-46bc-abd7-f656e2edc708', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 13:07:13.266123+00', '2024-06-10 13:07:13.266123+00', NULL);
INSERT INTO "public"."transactions" VALUES ('176bd86b-c669-47a9-8c46-64d594f67e30', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 13:07:26.965827+00', '2024-06-10 13:07:26.965827+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9b47a814-fe21-4925-bfc2-fe859fc2e41d', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6736743, 't', '2024-06-10 13:07:31.02673+00', '2024-06-10 13:07:31.02673+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e4e582b7-fa99-4203-a519-23258b2c88d1', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:13:53.540917+00', '2024-06-10 13:13:53.540917+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5588ce44-0a88-402b-8792-b938446f79e2', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:18:05.797433+00', '2024-06-10 13:18:05.797433+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c1303728-1d6c-4439-995a-1dbb5c41caa4', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:18:09.877617+00', '2024-06-10 13:18:09.877617+00', NULL);
INSERT INTO "public"."transactions" VALUES ('42ea3e10-7444-4f7f-99dc-d42830ee880a', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:19:52.33693+00', '2024-06-10 13:19:52.33693+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1f8041be-5373-49f8-a1f2-29296cc48353', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:28:01.065531+00', '2024-06-10 13:28:01.065531+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e4d85c41-4f07-45be-9613-f0de81dcfae2', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', '', 6768, 't', '2024-06-10 13:28:08.234966+00', '2024-06-10 13:28:08.234966+00', NULL);
INSERT INTO "public"."transactions" VALUES ('70b3d790-fcf6-4219-975f-f327dc62eb2d', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:28:18.238131+00', '2024-06-10 13:28:18.238131+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9e15c005-5aec-48c6-9093-1a3ea3bca1f8', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 13:50:38.086378+00', '2024-06-10 13:50:38.086378+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b0f12e8b-d7b5-4ccb-9956-a5a08ce9c4ed', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:15:52.982754+00', '2024-06-10 14:15:52.982754+00', NULL);
INSERT INTO "public"."transactions" VALUES ('a67897cb-b212-430d-8b04-d11976f82773', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:15:57.634475+00', '2024-06-10 14:15:57.634475+00', NULL);
INSERT INTO "public"."transactions" VALUES ('00e8ce00-6a92-489b-9cb2-5d9a5f633154', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:16:33.362223+00', '2024-06-10 14:16:33.362223+00', NULL);
INSERT INTO "public"."transactions" VALUES ('7ee04fd9-9040-4f87-8c3b-9a4a285f24b7', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:16:59.130525+00', '2024-06-10 14:16:59.130525+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c9d2b03a-a1a9-43df-a2c5-6dd10f238a1f', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:17:02.533865+00', '2024-06-10 14:17:02.533865+00', NULL);
INSERT INTO "public"."transactions" VALUES ('366f6718-bb19-42d8-a160-368581aa8354', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:17:27.369241+00', '2024-06-10 14:17:27.369241+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3ed77cb1-574c-4c13-99e2-db4a9db019c1', '', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 14:19:06.519237+00', '2024-06-10 14:19:06.519237+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0eb106c3-28a6-4f2b-9274-98c59e1252e9', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', '', 6768, 't', '2024-06-10 14:19:12.576918+00', '2024-06-10 14:19:12.576918+00', NULL);
INSERT INTO "public"."transactions" VALUES ('4425172b-ce0a-4393-98b9-86a01bb4fc3a', 'gfhjk', 'hgfdsa', 'surya apandi', '2000-01-01 00:00:00', 'bca', '', 6768, 't', '2024-06-10 14:25:01.222588+00', '2024-06-10 14:25:01.222588+00', NULL);
INSERT INTO "public"."transactions" VALUES ('cae60535-8a87-4851-a443-31f9579e70df', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 15:56:14.418183+00', '2024-06-10 15:56:14.418183+00', NULL);
INSERT INTO "public"."transactions" VALUES ('15482be3-59ba-4cb8-8ee9-e92176c1d24d', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-10 16:04:27.063019+00', '2024-06-10 16:04:27.063019+00', NULL);
INSERT INTO "public"."transactions" VALUES ('98923daf-08a4-4e49-80dc-1cef1e3a20c7', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:07:59.57428+00', '2024-06-10 16:07:59.57428+00', NULL);
INSERT INTO "public"."transactions" VALUES ('4403a8df-67d3-4908-b3bb-6d7df7112fad', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:12:27.181819+00', '2024-06-10 16:12:27.181819+00', NULL);
INSERT INTO "public"."transactions" VALUES ('86bb6cb6-5b89-481c-b137-2645d1e563c4', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:12:59.263166+00', '2024-06-10 16:12:59.263166+00', NULL);
INSERT INTO "public"."transactions" VALUES ('7a647c98-1200-4b84-896a-a9d86bf91399', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:18:16.917052+00', '2024-06-10 16:18:16.917052+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5e2d7a10-29ff-40e0-a392-a5d1a2e4a16d', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:22:16.318791+00', '2024-06-10 16:22:16.318791+00', NULL);
INSERT INTO "public"."transactions" VALUES ('da7f5c44-dc5c-455a-ad16-7aa08642911c', 'gfhjk', 'hgfdsa', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:24:01.021394+00', '2024-06-10 16:24:01.021394+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0abaf026-b1e6-4ffb-b990-f347822ce9f3', 'sdsdsfs', 'hgfdsfsdsa', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 16:47:11.150761+00', '2024-06-10 16:47:11.150761+00', NULL);
INSERT INTO "public"."transactions" VALUES ('796343b5-3d4d-44e0-b73c-d264c2bb156b', '00000000820000000209,00000000820000000209', 'hgfdsa', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-10 22:04:09.208561+00', '2024-06-10 22:04:09.208561+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3fddda7c-c594-42b7-ba90-c7a84a13328b', '00000000820000000209,00000000820000000209', 'hgfdsa', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-11 14:26:42.698699+00', '2024-06-11 14:26:42.698699+00', NULL);
INSERT INTO "public"."transactions" VALUES ('23d24c4c-eb23-4efd-9f57-9cfb30278cc1', '683748474276327', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-12 18:44:11.943654+00', '2024-06-12 18:44:11.943654+00', NULL);
INSERT INTO "public"."transactions" VALUES ('817fa924-78f8-4162-8048-d3bf1a3ca103', '683748474276327', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-12 18:44:17.563019+00', '2024-06-12 18:44:17.563019+00', NULL);
INSERT INTO "public"."transactions" VALUES ('a7bb2dd4-1b0b-4457-b390-50b969869530', '683748474276327', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-12 18:45:40.806507+00', '2024-06-12 18:45:40.806507+00', NULL);
INSERT INTO "public"."transactions" VALUES ('ce7110ca-5096-4504-b6c3-926cd4a6a216', '', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-12 18:45:59.921682+00', '2024-06-12 18:45:59.921682+00', NULL);
INSERT INTO "public"."transactions" VALUES ('609f3736-f8de-41f8-9a0f-aa70a7bf5657', '683748474276327', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 't', '2024-06-12 18:46:12.248328+00', '2024-06-12 18:46:12.248328+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d57df160-c085-4536-9cf9-44d629847301', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-14 20:15:16.635919+00', '2024-06-14 20:15:16.635919+00', NULL);
INSERT INTO "public"."transactions" VALUES ('cea09933-7aa3-4f06-90d8-f13427fa451b', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-14 20:24:19.602995+00', '2024-06-14 20:24:19.602995+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d80fcd28-e844-45e5-9194-3539f6dd1149', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-14 20:25:58.303078+00', '2024-06-14 20:25:58.303078+00', NULL);
INSERT INTO "public"."transactions" VALUES ('88df23dc-cb4d-4b28-8fab-ecd82e4fc388', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-14 20:31:47.027136+00', '2024-06-14 20:31:47.027136+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1059cc29-9aac-4154-b1e2-212789661a60', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-14 20:32:34.854978+00', '2024-06-14 20:32:34.854978+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b548a19d-84f0-4c34-ab62-71e66402f1d7', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-14 20:33:51.917022+00', '2024-06-14 20:33:51.917022+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f5192cdd-fdc1-475a-a450-adff60ca807c', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:42:43.747499+00', '2024-06-15 01:42:43.747499+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f831313d-34d4-450c-8682-6f519baa18cd', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:55:06.116959+00', '2024-06-15 01:55:06.116959+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6294e829-7a82-4a5b-8dcd-554238dbc7d9', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:55:45.385749+00', '2024-06-15 01:55:45.385749+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0025711f-41d4-4784-a19d-056e8144cb5f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:56:17.932324+00', '2024-06-15 01:56:17.932324+00', NULL);
INSERT INTO "public"."transactions" VALUES ('30eec780-9464-4a79-b613-1aae762cd043', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:31.649265+00', '2024-06-15 01:58:31.649265+00', NULL);
INSERT INTO "public"."transactions" VALUES ('a1c4b9cd-1bae-4ca4-97e8-35ec89c68ae4', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:33.314921+00', '2024-06-15 01:58:33.314921+00', NULL);
INSERT INTO "public"."transactions" VALUES ('a7f91426-38e3-491e-b960-c6476dd07a80', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:34.62852+00', '2024-06-15 01:58:34.62852+00', NULL);
INSERT INTO "public"."transactions" VALUES ('181e4185-d432-4f9a-a55b-e81694994c66', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:41.324188+00', '2024-06-15 01:58:41.324188+00', NULL);
INSERT INTO "public"."transactions" VALUES ('bf51d940-0fb2-4f63-b430-6aa8573f3392', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:43.372982+00', '2024-06-15 01:58:43.372982+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0385585c-bb3e-4c63-9e78-13256f8e19ce', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:47.222497+00', '2024-06-15 01:58:47.222497+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9059b456-b81e-43f0-947d-22133a9f315f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:48.361807+00', '2024-06-15 01:58:48.361807+00', NULL);
INSERT INTO "public"."transactions" VALUES ('255aa2e7-ef7e-481f-9e8f-713ee13765c6', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:49.492967+00', '2024-06-15 01:58:49.492967+00', NULL);
INSERT INTO "public"."transactions" VALUES ('775eed0b-737a-4aa0-8fd4-7e633a8c020e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:53.85166+00', '2024-06-15 01:58:53.85166+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d64a2648-6308-432e-9875-9b647ee26169', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:55.234442+00', '2024-06-15 01:58:55.234442+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b863a10c-8ea6-4999-94d6-e6a980bc45b6', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:56.372176+00', '2024-06-15 01:58:56.372176+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5566a415-3b95-4fbf-803b-71d487c38fa9', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:57.5162+00', '2024-06-15 01:58:57.5162+00', NULL);
INSERT INTO "public"."transactions" VALUES ('68162609-f0b9-4f0d-950f-c23c9ecd9788', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:58.630773+00', '2024-06-15 01:58:58.630773+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d269cb9c-ec92-466e-b6f1-93448260ef3a', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 01:58:59.969678+00', '2024-06-15 01:58:59.969678+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c8388a27-a85c-42df-b6ea-b842f312ebdc', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:09:02.856879+00', '2024-06-15 02:09:02.856879+00', NULL);
INSERT INTO "public"."transactions" VALUES ('35177354-e7ad-4b76-85bc-a647fb6f3017', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:11:25.436874+00', '2024-06-15 02:11:25.436874+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e573b0b8-6358-47ea-8b28-8de70e5d5656', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:11:27.25417+00', '2024-06-15 02:11:27.25417+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d1a0d11c-77c2-4c08-b5b9-441cb627a92e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:11:34.781168+00', '2024-06-15 02:11:34.781168+00', NULL);
INSERT INTO "public"."transactions" VALUES ('ab67341d-1eab-40e6-8658-616deb75a3cc', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:11:49.428934+00', '2024-06-15 02:11:49.428934+00', NULL);
INSERT INTO "public"."transactions" VALUES ('94cc026c-97c2-4d8b-9cab-29d13388a5b4', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:11:50.670371+00', '2024-06-15 02:11:50.670371+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6ca3e957-bee5-42b2-9af7-c2748d48a363', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:20:09.204229+00', '2024-06-15 02:20:09.204229+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0f79839b-855a-4d7d-b664-b418620f8121', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:20:11.095347+00', '2024-06-15 02:20:11.095347+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2a9405bf-0fb5-44d7-bbb9-db607480c614', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:20:16.3639+00', '2024-06-15 02:20:16.3639+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9a1664e8-9c6d-42d9-baba-4a50f88ac303', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:28:05.672217+00', '2024-06-15 02:28:05.672217+00', NULL);
INSERT INTO "public"."transactions" VALUES ('fc4db76b-6d2a-4d95-bc51-e146b55ba59b', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:28:07.334777+00', '2024-06-15 02:28:07.334777+00', NULL);
INSERT INTO "public"."transactions" VALUES ('44bd2f0a-7fc8-48f1-855a-129f777de11f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:28:08.596279+00', '2024-06-15 02:28:08.596279+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e6df0924-03b6-4eba-b378-e77473e98c97', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:28:24.923392+00', '2024-06-15 02:28:24.923392+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5bf13b2f-69c2-44ba-abc6-f05b577ab6be', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:28:28.356446+00', '2024-06-15 02:28:28.356446+00', NULL);
INSERT INTO "public"."transactions" VALUES ('af641b9c-3653-417e-a44a-cd1650db2076', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:34:52.953139+00', '2024-06-15 02:34:52.953139+00', NULL);
INSERT INTO "public"."transactions" VALUES ('8e4a707a-2d2b-4991-a077-a6fa8f309d6e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 02:36:14.100687+00', '2024-06-15 02:36:14.100687+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2b538f4d-e5cb-4a5c-afac-bcd01962daaa', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-15 17:55:30.212914+00', '2024-06-15 17:55:30.212914+00', NULL);
INSERT INTO "public"."transactions" VALUES ('0b8dcd35-abc0-4944-80ab-7e8f423ebc04', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-16 21:30:15', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 14:30:15.147296+00', '2024-06-16 14:30:15.147296+00', NULL);
INSERT INTO "public"."transactions" VALUES ('724a10cf-785c-4bfe-b12b-70a6fb42ebb5', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-16 21:31:28', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 14:31:27.706654+00', '2024-06-16 14:31:27.706654+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f244b590-6f6c-4bcf-a606-b4121c01fabc', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-16 21:31:29', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 14:31:28.791621+00', '2024-06-16 14:31:28.791621+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3001ecc4-018d-4b1b-90b5-428bb119cd39', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-16 21:31:30', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 14:31:29.977966+00', '2024-06-16 14:31:29.977966+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9df1a6ec-2913-4149-bfee-d8d82f51c4ae', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-16 21:31:31', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 14:31:31.154071+00', '2024-06-16 14:31:31.154071+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9980d913-1ab0-4c20-9190-c10a3bc5ae62', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 00:51:26', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 17:51:25.905472+00', '2024-06-16 17:51:25.905472+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3705f45f-e776-4c30-8599-d5ed293c76b8', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:03:14', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 18:03:14.072637+00', '2024-06-16 18:03:14.072637+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1dcb1464-9de2-41c9-bce6-f9dc19d84946', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:03:52', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 18:03:52.394509+00', '2024-06-16 18:03:52.394509+00', NULL);
INSERT INTO "public"."transactions" VALUES ('807f5761-4fef-4a5f-a079-616d9bce274d', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:04:27', 'bca', 'vhdjdfgshjfsdgfhs', 6768, 'f', '2024-06-16 18:04:26.513244+00', '2024-06-16 18:04:26.513244+00', NULL);
INSERT INTO "public"."transactions" VALUES ('4417adb6-0da9-405b-abb0-ab5af4f6fba2', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:16:26', 'bca', 'vhdjdfgshjfsdgfhs', 200000, 'f', '2024-06-16 18:16:25.53219+00', '2024-06-16 18:16:25.53219+00', NULL);
INSERT INTO "public"."transactions" VALUES ('7f7ca6e9-301d-4b95-900c-a12ed18ab570', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:16:43', 'bca', 'vhdjdfgshjfsdgfhs', 200000, 'f', '2024-06-16 18:16:43.054974+00', '2024-06-16 18:16:43.054974+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f86fdd73-ad48-4f22-9640-e393d1724f82', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:17:26', 'bca', 'vhdjdfgshjfsdgfhs', 200000, 'f', '2024-06-16 18:17:26.058196+00', '2024-06-16 18:17:26.058196+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f088f7fb-0756-4034-be68-c0ffaf84a945', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:28:38', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:28:38.428924+00', '2024-06-16 18:28:38.428924+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f7eba9f9-2910-4af0-a35e-222cf28d656e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:30:11', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:30:10.513141+00', '2024-06-16 18:30:10.513141+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6fcc7e04-3aa5-4f83-a132-42272d937b2a', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:30:32', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:30:32.256337+00', '2024-06-16 18:30:32.256337+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f62a2da2-e287-4db6-8c35-0cb7bdeda638', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:31:02', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:31:01.700104+00', '2024-06-16 18:31:01.700104+00', NULL);
INSERT INTO "public"."transactions" VALUES ('79e82e7c-1631-406d-9e50-36ffc95fc80c', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:33:35', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:33:34.578626+00', '2024-06-16 18:33:34.578626+00', NULL);
INSERT INTO "public"."transactions" VALUES ('139c7b47-eadc-41e0-a030-3fae8eb0312d', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:34:08', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:34:07.523479+00', '2024-06-16 18:34:07.523479+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1749082d-dcc7-4c7e-9a4b-d385adf25151', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:34:53', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:34:52.789854+00', '2024-06-16 18:34:52.789854+00', NULL);
INSERT INTO "public"."transactions" VALUES ('eed6ebc3-7a81-4ad0-8610-a76361ab8e45', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:35:18', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:35:18.297517+00', '2024-06-16 18:35:18.297517+00', NULL);
INSERT INTO "public"."transactions" VALUES ('def982c3-90cb-4f9a-80f7-0f74101c5795', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:36:27', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:36:26.985419+00', '2024-06-16 18:36:26.985419+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c3a26e83-f45e-45b9-8087-c5c95fcbda02', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:37:19', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:37:18.839233+00', '2024-06-16 18:37:18.839233+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d8ecae44-a81d-497b-a147-510d7558dc8f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:37:39', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:37:38.758563+00', '2024-06-16 18:37:38.758563+00', NULL);
INSERT INTO "public"."transactions" VALUES ('8c2c1733-e695-4381-9bba-d5bad1f8d75e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:42:11', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:42:10.872429+00', '2024-06-16 18:42:10.872429+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e1a8b765-3708-4d9f-96f8-0e932963e573', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', 'gdhsfjsdf', 'anom', '2024-06-17 01:43:03', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 18:43:03.024533+00', '2024-06-16 18:43:03.024533+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c9834676-34e2-4328-937b-3a7e30c49b9f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70152', 'anom', '2024-06-17 02:53:58', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 19:53:57.617549+00', '2024-06-16 19:53:57.617549+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e31c0f0d-79a1-4023-80e0-4625b0d4c5f4', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'anom', '2024-06-17 03:44:08', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 20:44:07.970669+00', '2024-06-16 20:44:07.970669+00', NULL);
INSERT INTO "public"."transactions" VALUES ('77a242f8-46ba-4c64-bd3c-9eadf6dbf698', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-17 03:50:39', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 20:50:39.093795+00', '2024-06-16 20:50:39.093795+00', NULL);
INSERT INTO "public"."transactions" VALUES ('5582b392-571f-4134-bdde-b91db12729a9', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-17 04:12:52', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 21:12:52.42135+00', '2024-06-16 21:12:52.42135+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b10afdcd-5691-40c9-a73c-fe164c2783cc', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-17 04:13:24', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 21:13:24.147539+00', '2024-06-16 21:13:24.147539+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c71693ed-33e5-4edd-b3b1-fce8be16ecd0', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-17 04:14:39', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-16 21:14:39.148373+00', '2024-06-16 21:14:39.148373+00', NULL);
INSERT INTO "public"."transactions" VALUES ('73d5f389-c588-423d-b4a0-3e56f331bed0', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-17 23:52:56', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-17 16:52:56.457213+00', '2024-06-17 16:52:56.457213+00', NULL);
INSERT INTO "public"."transactions" VALUES ('63379bc2-9a5c-429a-8505-df0fcf83a953', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 00:00:55', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-17 17:00:55.498459+00', '2024-06-17 17:00:55.498459+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2ab39286-0746-4321-8c74-b284d5939823', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 00:01:46', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-17 17:01:45.533712+00', '2024-06-17 17:01:45.533712+00', NULL);
INSERT INTO "public"."transactions" VALUES ('80d2215c-8b54-4e41-b93b-a2942a18c4b4', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 00:04:05', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-17 17:04:04.588944+00', '2024-06-17 17:04:04.588944+00', NULL);
INSERT INTO "public"."transactions" VALUES ('c9a3c058-2c8f-4989-8b26-f46a73dca016', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 00:55:17', 'bca', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-17 17:55:16.75818+00', '2024-06-17 17:55:16.75818+00', NULL);
INSERT INTO "public"."transactions" VALUES ('41aed409-7b9d-4a48-b639-edb602680b7e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 00:56:21', 'bca_va', 'vhdjdfgshjfsdgfhs', 222000, 'f', '2024-06-17 17:56:20.543878+00', '2024-06-17 17:56:20.543878+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d0023607-9215-486a-80f4-62775e521e9d', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 01:16:37', 'other_qris', 'https://app.sandbox.midtrans.com/snap/v4/redirection/56fe12e6-a7d0-45bf-ba80-873731145231', 222000, 'f', '2024-06-17 18:16:36.971454+00', '2024-06-17 18:16:36.971454+00', NULL);
INSERT INTO "public"."transactions" VALUES ('f6748771-b2cb-466b-9d06-216cece69fd3', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 01:18:14', 'other_qris', 'https://app.sandbox.midtrans.com/snap/v4/redirection/7d605526-ec64-4280-b465-1bfbe15bb928', 222000, 'f', '2024-06-17 18:18:14.071904+00', '2024-06-17 18:18:14.071904+00', NULL);
INSERT INTO "public"."transactions" VALUES ('730dd137-5012-4a31-b461-c095cafe5d18', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 01:21:02', 'other_qris', 'https://app.sandbox.midtrans.com/snap/v4/redirection/fbd7dafc-4a86-4abd-8fa3-f639241db65f', 222000, 'f', '2024-06-17 18:21:02.203801+00', '2024-06-17 18:21:02.203801+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2c2b836d-8e18-4733-ae01-baf8b0362451', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 01:22:02', 'other_qris', 'https://app.sandbox.midtrans.com/snap/v4/redirection/5432933b-66de-423b-b9ad-57b995871021', 222000, 'f', '2024-06-17 18:22:02.354575+00', '2024-06-17 18:22:02.354575+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d1de9856-ad5d-4264-9716-db23b11268d2', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 02:40:04', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/0a688c51-ffb8-47aa-9b5a-e037af201379', 222000, 'f', '2024-06-17 19:40:03.617812+00', '2024-06-17 19:40:03.617812+00', NULL);
INSERT INTO "public"."transactions" VALUES ('2b703897-b4be-47c8-a729-e053da7cbdcc', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 02:52:50', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/36cb5094-a752-403d-bd3a-c2f4f0303ebc', 222000, 'f', '2024-06-17 19:52:50.181444+00', '2024-06-17 19:52:50.181444+00', NULL);
INSERT INTO "public"."transactions" VALUES ('6b1deef7-7723-46fc-b9a4-7906c4467481', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 12:45:13', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/d76b53f8-f777-4051-9155-d7778a31c4bb', 222000, 'f', '2024-06-18 05:45:12.681547+00', '2024-06-18 05:45:12.681547+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9de1c5d6-f1cb-47e4-8e33-8a39e089db9d', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 12:59:37', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/21ff5b0d-e7ab-4d3c-a674-a5eba8f31e6b', 222000, 'f', '2024-06-18 05:59:37.211407+00', '2024-06-18 05:59:37.211407+00', NULL);
INSERT INTO "public"."transactions" VALUES ('419e9d6c-38a9-4dcd-9eeb-9d38fa1df018', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 12:59:55', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/fdf018ba-eefc-4339-af44-a22c7e5bc79e', 222000, 'f', '2024-06-18 05:59:55.347422+00', '2024-06-18 05:59:55.347422+00', NULL);
INSERT INTO "public"."transactions" VALUES ('d5b00e27-c279-4eaa-a327-e8e74ae50ab0', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 12:59:57', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/47e23aa3-3367-47f0-8ecf-6dea852d0ba0', 222000, 'f', '2024-06-18 05:59:57.408221+00', '2024-06-18 05:59:57.408221+00', NULL);
INSERT INTO "public"."transactions" VALUES ('9605a4aa-3612-489c-b058-1591ba6610ee', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 13:49:53', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/e1403f1f-ceba-4bd7-b703-6a4ab388e638', 222000, 'f', '2024-06-18 06:49:53.249326+00', '2024-06-18 06:49:53.249326+00', NULL);
INSERT INTO "public"."transactions" VALUES ('40538e2d-180e-44ea-8807-b4c8944ac699', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 13:51:02', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/ef96ce8c-1d0c-488b-885d-4c4fe4a15399', 222000, 'f', '2024-06-18 06:51:01.748411+00', '2024-06-18 06:51:01.748411+00', NULL);
INSERT INTO "public"."transactions" VALUES ('cdbc3b08-d628-4992-b9fb-f1e32acc21f8', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 00:12:51', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/7d322406-e41c-44ec-9e75-8b3b9679ce8d', 222000, 't', '2024-06-20 17:12:51.192908+00', '2024-06-21 06:34:27.739614+00', NULL);
INSERT INTO "public"."transactions" VALUES ('15726a5f-20ce-4f88-9429-b160f28ab356', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-19 04:16:05', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/44b74150-dc25-42f0-9313-33c19f940fa4', 222000, 'f', '2024-06-18 21:16:04.763841+00', '2024-06-18 21:16:04.763841+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b5542e81-9b1c-48d4-838a-7ae303f12775', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70151', 'Robert Ramirez', '2024-06-19 03:18:27', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/98e2b05c-8b21-488f-bda9-a706af4984d5', 222000, 'f', '2024-06-18 20:18:26.752244+00', '2024-06-18 20:18:26.752244+00', NULL);
INSERT INTO "public"."transactions" VALUES ('838cb275-be97-43cd-bbff-2ddc0fdde336', '08043627-40cb-4f5f-9c35-191ddc8f6398', '212d8d3d-7840-45a9-8393-d929b6a24b48', 'surya', '2000-01-01 00:00:00', 'bca', 'vhdjdfgshjfsdgfhs', 45634, 'f', '2024-06-07 18:02:04.570852+00', '2024-06-07 18:02:04.570852+00', NULL);
INSERT INTO "public"."transactions" VALUES ('ca02359e-cb94-4d15-9ed8-402bfe2f4180', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-19 02:52:38', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b2c3a698-0531-4e2d-941e-f59c6c6969cb', 222000, 't', '2024-06-18 19:52:37.867133+00', '2024-06-20 14:43:41.265358+00', NULL);
INSERT INTO "public"."transactions" VALUES ('982896d1-e6e3-4387-ad8a-09bbcd18ddff', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-20 21:45:04', 'permata_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/60b49bce-4528-43dd-8043-5a0f5e1f410e', 222000, 'f', '2024-06-20 14:45:03.782485+00', '2024-06-20 14:45:03.782485+00', NULL);
INSERT INTO "public"."transactions" VALUES ('8fceb94b-f1be-486e-8c0d-15c3b8e7e78e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-20 21:47:54', 'indomaret', 'https://app.sandbox.midtrans.com/snap/v4/redirection/7d38856d-6a16-4bec-af56-0bb2d4add8f6', 222000, 'f', '2024-06-20 14:47:53.540461+00', '2024-06-20 14:47:53.540461+00', NULL);
INSERT INTO "public"."transactions" VALUES ('29fcb035-8d2a-40f4-96f5-c17b0e53fe34', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-18 23:49:43', 'bca_va', 'https://app.sandbox.midtrans.com/snap/v4/redirection/1b033a67-cac7-497a-aa13-aea270c7a5ee', 222000, 't', '2024-06-18 16:49:43.424439+00', '2024-06-18 19:52:03.716046+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3ad12d9a-dadd-4c2b-a0d6-fd97f58e14df', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-20 21:47:39', 'other_qris', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b2840ba8-cce8-4b76-b762-95c8d8fa5888', 222000, 't', '2024-06-20 14:47:38.577908+00', '2024-06-20 14:52:25.434458+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b4072cf3-00f8-4175-8856-3214c076cf3e', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', '2024-06-21 00:07:20', 'indomaret', 'https://app.sandbox.midtrans.com/snap/v4/redirection/4fadddaa-64e9-4edf-87a5-dccd6f11483b', 222000, 'f', '2024-06-20 17:07:20.160595+00', '2024-06-20 17:07:20.160595+00', NULL);
INSERT INTO "public"."transactions" VALUES ('14cdd615-c0d9-46c2-b0c4-c631ed8ac46f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 00:12:42', 'indomaret', 'https://app.sandbox.midtrans.com/snap/v4/redirection/1d31e285-4c77-4d23-91ad-9f6c4d1ce11f', 222000, 'f', '2024-06-20 17:12:41.539237+00', '2024-06-20 17:12:41.539237+00', NULL);
INSERT INTO "public"."transactions" VALUES ('3bc62cbd-3669-4f57-adee-c708e5729c1b', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 15:33:07', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c47e7fb2-6939-4636-8aa1-b0b8fe0d5318', 222000, 'f', '2024-06-21 08:33:06.784087+00', '2024-06-21 08:33:06.784087+00', NULL);
INSERT INTO "public"."transactions" VALUES ('4af5a117-df8c-4bee-a89c-f4dad606614f', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 15:33:19', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/1ab231d5-95cd-4e87-99e5-bfe879a35303', 222000, 'f', '2024-06-21 08:33:18.985748+00', '2024-06-21 08:33:18.985748+00', NULL);
INSERT INTO "public"."transactions" VALUES ('1dba277b-78f8-4e5f-8825-1e1ab75e3854', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 01:05:20', 'bca_klikbca', 'https://app.sandbox.midtrans.com/snap/v4/redirection/2f3e366f-7fd5-4bb4-a8c9-a0d77a8831b9', 222000, 'f', '2024-06-20 18:05:19.516457+00', '2024-06-20 18:05:19.516457+00', NULL);
INSERT INTO "public"."transactions" VALUES ('b33997f1-7e68-45ef-bca7-fbb174d8ac39', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 01:05:51', 'uob_ezpay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/40b17a51-215d-40e5-aa9a-60a3a8df531d', 222000, 'f', '2024-06-20 18:05:51.166637+00', '2024-06-20 18:05:51.166637+00', NULL);
INSERT INTO "public"."transactions" VALUES ('a9af7a10-96a6-46e8-8eb1-a86d949fb003', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 01:06:24', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/87ba749c-b835-4c51-aac8-1d856c3bded9', 222000, 'f', '2024-06-20 18:06:23.775312+00', '2024-06-20 18:06:23.775312+00', NULL);
INSERT INTO "public"."transactions" VALUES ('35fabb96-60a5-468a-9f98-59a19eef7a7a', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 15:35:44', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c99397de-5699-47ff-b975-7f9f7b330d25', 222000, 'f', '2024-06-21 08:35:43.905905+00', '2024-06-21 08:35:43.905905+00', NULL);
INSERT INTO "public"."transactions" VALUES ('136e43ae-692d-422b-9e45-e7ed54ea7fe1', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 15:36:38', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/24d1936b-f530-4134-ba11-52b425d0683e', 222000, 'f', '2024-06-21 08:36:37.845001+00', '2024-06-21 08:36:37.845001+00', NULL);
INSERT INTO "public"."transactions" VALUES ('071b815a-291a-4bcc-bfaf-44994e5538d5', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 15:36:51', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c23a7a27-ad55-47f5-88ff-e7b1b4384a72', 222000, 'f', '2024-06-21 08:36:50.770305+00', '2024-06-21 08:36:50.770305+00', NULL);
INSERT INTO "public"."transactions" VALUES ('38e6598e-7503-462a-92c1-a726ed110612', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 19:34:17', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/6bb87527-51e2-45fb-a494-acfd18914f8f', 222000, 'f', '2024-06-21 12:34:16.707649+00', '2024-06-21 12:34:16.707649+00', NULL);
INSERT INTO "public"."transactions" VALUES ('e880887f-4bda-4e24-9118-fc2109a99801', 'ac6eace3-d4fd-69cf-085a-21f8aa49ee75', '07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', '2024-06-21 19:39:59', 'shopeepay', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c2ed48a0-21f9-4243-bac8-7a4617aab229', 222000, 'f', '2024-06-21 12:39:59.269112+00', '2024-06-21 12:39:59.269112+00', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "user_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "fullname" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "phone" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "status" bool DEFAULT true,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6),
  "verification" bool DEFAULT false,
  "verification_code" varchar(255) COLLATE "pg_catalog"."default",
  "reset_code" varchar(255) COLLATE "pg_catalog"."default",
  "reset_code_expires_at" date,
  "jwt_token" varchar(255) COLLATE "pg_catalog"."default",
  "jwt_token_expires_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES ('07b553ae-736f-4f5a-aaf7-343457cab5bd', 'Surya Apandi', 'surya.apandi20@gmail.com', '$2a$10$bd4MSj5RKL2IP264SC0TQuTnGZTjDbya8Vk0WsnG/WcDP/U/.MR.G', '081298790174', 'user', 't', '2024-06-20 17:11:03.318386+00', '2024-06-23 10:28:36.407794+00', NULL, 'f', '278549', '', '0001-01-01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA3YjU1M2FlLTczNmYtNGY1YS1hYWY3LTM0MzQ1N2NhYjViZCIsImVtYWlsIjoic3VyeWEuYXBhbmRpMjBAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpc3MiOiJEZXB1YmxpYyIsImV4cCI6MTcxOTIyNDkxNn0.7IihUsC9IGxBJ8h60cka5tYcqr8m3iiFAayqkcfZNuU', '2024-06-24 10:28:36.384108+00');
INSERT INTO "public"."users" VALUES ('665e3bd5-8351-f89f-bea8-975c110266bb', 'Tang Zhennan', 'zhentang4@gmail.com', 'SQ7JQlOGev', '769-1368-5827', 'user', 'f', '2001-03-30 00:42:04+00', '2001-01-07 03:59:11+00', '2008-03-24 14:32:03+00', 't', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('8095aa2c-df50-4f48-9ea3-fcdcd262ad41', 'Nakamura Mio', 'nmio@hotmail.com', 'cwHgpmZPEC', '193-3954-4955', 'user', 't', '2022-02-20 04:58:33+00', '2017-08-11 20:09:23+00', '2021-12-08 06:14:23+00', 't', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('7cfb15ce-1b77-8ae3-45d0-b7b43a957aff', 'Joan Dixon', 'dixon214@yahoo.com', '90xcSVL4dj', '7401 498684', 'user', 't', '2007-03-02 00:07:12+00', '2000-09-12 10:21:00+00', '2012-08-12 05:13:42+00', 't', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('b6eb5c2c-92db-5953-4811-31c63f063ba8', 'Susan Martinez', 'smartinez@hotmail.com', '9Alc9covm6', '164-4625-6368', 'DqY7j31srL', 'f', '2013-05-14 15:49:08+00', '2017-06-14 05:47:01+00', '2009-04-22 23:05:54+00', 'f', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('53e03434-b055-43c9-977b-ff2a57c47ac1', 'kevin', 'kevin123@gmail.com', '123', '12314324', 'admin', 't', '2024-06-06 15:59:13.767023+00', '2024-06-06 15:59:13.767023+00', NULL, 'f', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('10a3343f-6646-ada1-b88c-b8c71d459b5a', 'Christine Martin', 'martin77@yahoo.com', 'cToTJAp939', '312-543-6980', 'user', 'f', '2019-03-30 16:56:02+00', '2023-04-10 01:00:23+00', '2008-01-13 05:01:52+00', 't', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('192f7a13-8439-44c0-bcbe-f59a2e835a0f', 'admin', 'surya.apandi28@gmail.com', '$2a$10$4cXPvT67fJjV0iAungGtd.3RdPobITW1Y25s6h2gc3f0oDPQxeapC', '', 'admin', 't', '2024-06-20 17:04:01.123647+00', '2024-06-23 10:09:26.562206+00', NULL, 'f', NULL, NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE5MmY3YTEzLTg0MzktNDRjMC1iY2JlLWY1OWEyZTgzNWEwZiIsImVtYWlsIjoic3VyeWEuYXBhbmRpMjhAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiaXNzIjoiRGVwdWJsaWMiLCJleHAiOjE3MTkxNDA5NjZ9.yUwV4dCbkoZauW050iyJoVPEBdydQAWif_cQMJhORZY', '2024-06-23 11:09:26.508726+00');
INSERT INTO "public"."users" VALUES ('732ea7b8-9fd4-446d-8e15-6d7fa3e70153', 'Robert Ramirez', 'roramirez@icloud.com', 'BkLFxzlO1O', '81298790174', 'user', 't', '2013-07-22 11:48:47+00', '2007-02-12 07:59:50+00', '2000-11-10 06:57:54+00', 't', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."users" VALUES ('6dbf3399-5d22-4d12-ba6c-e1d9b9a303b8', 'Surya Apandi', 'surya.apandi20@gmail.co', '$2a$10$q9m5F3WfBvEO4z5R16zc0erob2Vi5LJ1Wm.GUx/nnJhMUtlV6peKK', '081298790174', 'user', 't', '2024-06-21 07:03:55.788993+00', '2024-06-21 07:04:09.400585+00', NULL, 'f', '548717', '', '0001-01-01', NULL, NULL);
INSERT INTO "public"."users" VALUES ('21b243aa-9c8a-4cdd-8b13-3c815d583a50', 'admin', 'surya.apandi28@gmail.com', '$2a$10$.5nY7JvVdK2ryDovOc2LtOgqIDRf8r5sGQ/hKwVEAzuhu4oo3JuFi', '', 'admin', 't', '2024-06-20 17:05:29.620532+00', '2024-06-21 15:53:30.385988+00', NULL, 'f', '904343', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxYjI0M2FhLTljOGEtNGNkZC04YjEzLTNjODE1ZDU4M2E1MCIsImVtYWlsIjoic3VyeWEuYXBhbmRpMjhAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiaXNzIjoiRGVwdWJsaWMiLCJleHAiOjE3MTg5ODg4MTB9.ZOEPUOCDYL0O5HKRpES6fMKQIknosN4JUHUaLsWiJ48', '2024-06-21 16:53:30.363027+00');
INSERT INTO "public"."users" VALUES ('d55b9476-8853-4116-96d9-ed4056e699bc', 'admin', 'ganta.kon1@gmail.com', '$2a$10$XY0DZxNiH5PG1O.T.aFI.uZy7VfjMuj3EHMsfVCVmAT1S5pHhCQ5S', '', 'admin', 't', '2024-06-23 12:50:34.549785+00', '2024-06-23 12:50:51.734222+00', NULL, 'f', '349746', NULL, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ1NWI5NDc2LTg4NTMtNDExNi05NmQ5LWVkNDA1NmU2OTliYyIsImVtYWlsIjoiZ2FudGEua29uMUBnbWFpbC5jb20iLCJyb2xlIjoiYWRtaW4iLCJpc3MiOiJEZXB1YmxpYyIsImV4cCI6MTcxOTIzMzQ0M30.Zo-LSbGNl1Kiz9OD-GySOdbZa2BV1A-4USHTOvlX0Bc', '2024-06-24 12:50:43.416503+00');
INSERT INTO "public"."users" VALUES ('f3e634fc-0139-4bd7-9350-39bc08cf4b55', 'Kevin Majesta', 'kevinivano1205@gmail.com', '$2a$10$mL3a9r.znhX9RB8Bx5lVqu3Kr8Vyfs2Zvuzj1WpDK5pW8iSUDziW2', '1290378129', 'user', 't', '2024-06-23 12:50:37.952984+00', '2024-06-23 12:50:53.467156+00', NULL, 'f', '074442', '', '0001-01-01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYzZTYzNGZjLTAxMzktNGJkNy05MzUwLTM5YmMwOGNmNGI1NSIsImVtYWlsIjoia2V2aW5pdmFubzEyMDVAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJpc3MiOiJEZXB1YmxpYyIsImV4cCI6MTcxOTIzMzQ0MX0.gyU38N6buy6yjB_pO93S3Fv-SdIE3BbYHY7TLDpsJU0', '2024-06-24 12:50:41.100517+00');

-- ----------------------------
-- Table structure for wishlists
-- ----------------------------
DROP TABLE IF EXISTS "public"."wishlists";
CREATE TABLE "public"."wishlists" (
  "wishlist_id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "event_id" uuid NOT NULL,
  "created_at" timestamptz(6) NOT NULL DEFAULT now(),
  "updated_at" timestamptz(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamptz(6)
)
;

-- ----------------------------
-- Records of wishlists
-- ----------------------------
INSERT INTO "public"."wishlists" VALUES ('fcd86bf4-522b-4d61-b1a8-718a1acc45ae', 'b9d8cfb4-3601-6f6f-d081-57e4d34e1391', '4df542eb-4a94-4e23-88ea-d99d78d47aad', '2024-06-20 17:33:09.046228+00', '2024-06-20 17:33:09.046228+00', NULL);
INSERT INTO "public"."wishlists" VALUES ('3eff6817-0af6-41ad-93ab-1837e41cdb33', 'b9d8cfb4-3601-6f6f-d081-57e4d34e1395', '4df542eb-4a94-4e23-88ea-d99d78d47aad', '2024-06-20 17:34:25.131569+00', '2024-06-20 17:34:25.131569+00', NULL);

-- ----------------------------
-- Primary Key structure for table carts
-- ----------------------------
ALTER TABLE "public"."carts" ADD CONSTRAINT "carts_pkey" PRIMARY KEY ("cart_id");

-- ----------------------------
-- Primary Key structure for table event_categories
-- ----------------------------
ALTER TABLE "public"."event_categories" ADD CONSTRAINT "event_categories_pkey" PRIMARY KEY ("event_categories_id");

-- ----------------------------
-- Primary Key structure for table events
-- ----------------------------
ALTER TABLE "public"."events" ADD CONSTRAINT "events_pkey" PRIMARY KEY ("event_id");

-- ----------------------------
-- Primary Key structure for table notifications
-- ----------------------------
ALTER TABLE "public"."notifications" ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("notification_id");

-- ----------------------------
-- Primary Key structure for table schema_migrations
-- ----------------------------
ALTER TABLE "public"."schema_migrations" ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");

-- ----------------------------
-- Primary Key structure for table tickets
-- ----------------------------
ALTER TABLE "public"."tickets" ADD CONSTRAINT "tickets_pkey" PRIMARY KEY ("tickets_id");

-- ----------------------------
-- Primary Key structure for table transaction_details
-- ----------------------------
ALTER TABLE "public"."transaction_details" ADD CONSTRAINT "transaction_details_pkey" PRIMARY KEY ("transaction_details_id");

-- ----------------------------
-- Primary Key structure for table transactions
-- ----------------------------
ALTER TABLE "public"."transactions" ADD CONSTRAINT "transactions_pkey" PRIMARY KEY ("transactions_id");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table wishlists
-- ----------------------------
ALTER TABLE "public"."wishlists" ADD CONSTRAINT "wishlists_pkey" PRIMARY KEY ("wishlist_id");
