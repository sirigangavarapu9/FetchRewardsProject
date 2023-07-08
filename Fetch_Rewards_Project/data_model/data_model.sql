CREATE TABLE "brands" (
  "id" varchar PRIMARY KEY,
  "barcode" varchar,
  "category" varchar,
  "categoryCode" varchar,
  "cpg_id" varchar,
  "name" varchar,
  "brandCode" varchar,
  "topBrand" boolean
);

CREATE TABLE "cpg" (
  "id" varchar PRIMARY KEY,
  "ref" varchar
);

CREATE TABLE "receipts" (
  "id" varchar PRIMARY KEY,
  "bonusPointsEarned" int,
  "bonusPointsEarnedReason" varchar,
  "createDate" timestamp,
  "dateScanned" timestamp,
  "finishedDate" timestamp,
  "modifyDate" timestamp,
  "pointsAwardedDate" timestamp,
  "pointsEarned" varchar,
  "purchaseDate" timestamp,
  "purchasedItemCount" int,
  "rewardsReceiptStatus" varchar,
  "totalSpent" varchar,
  "user_id" varchar
);

CREATE TABLE "rewardsReceiptItemList" (
  "id" varchar PRIMARY KEY,
  "barcode" varchar,
  "description" varchar,
  "finalPrice" varchar,
  "itemPrice" varchar,
  "needsFetchReview" boolean,
  "partnerItemId" varchar,
  "preventTargetGapPoints" boolean,
  "quantityPurchased" int,
  "userFlaggedBarcode" varchar,
  "userFlaggedNewItem" boolean,
  "userFlaggedPrice" varchar,
  "userFlaggedQuantity" int,
  "pointsPayerId" varchar,
  "rewardsGroup" varchar,
  "rewardsProductPartnerId" varchar,
  "targetPrice" varchar,
  "competitiveProduct" boolean,
  "deleted" boolean,
  "receipt_id" varchar
);

CREATE TABLE "users" (
  "id" varchar PRIMARY KEY,
  "active" boolean,
  "createdDate" timestamp,
  "lastLogin" timestamp,
  "role" varchar,
  "signUpSource" varchar,
  "state" varchar
);

ALTER TABLE "brands" ADD FOREIGN KEY ("cpg_id") REFERENCES "cpg" ("id");

ALTER TABLE "receipts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "rewardsReceiptItemList" ADD FOREIGN KEY ("receipt_id") REFERENCES "receipts" ("id");
