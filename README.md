## 1. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

প্রাইমারি কী ঃ প্রাইমারি কী হলো এমন একটি কী যেটা একটি টেবিলের প্রতিটি সারিকে ইউনিকভাবে আইডেনটিফাই করতে পারে। প্রতিটি টেবিলে একটি মাত্র প্রাইমারি কী থাকে । এটির ভ্যালু নাল হয় না এবং যে কলামকে প্রাইমারি কী ধরা হয় তার প্রতিটি সারিতে ইউনিক ভ্যালু থাকে।

ফরেন কীঃ একটি টেবিলের প্রাইমারি কী যখন অন্য একটি টেবিলে ব্যবহৃত হয়, তখন অন্য টেবিলে তাকে ফরেন কী বলে। এটি দুটি টেবিলের মধ্যে সম্পর্ক স্থাপন করে এবং একটি টেবিলে একাধিক ফরেন কী থাকতে পারে।

একটি উদাহারনের মাধ্যমে আমরা বুঝতে পারি...

```
CREATE TABLE products(
    product_id INT SERIAL PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    image_url TEXT,
    category VARCHAR(80),
    price NUMERIC(10,2),
    stock INT

)
```

এখানে products নামে একটি টেবিল তৈরী করার কমান্ড রয়েছে, যেখানে product_id কে প্রাইমারে কী নেয়া হয়েছে। ফলে, এর মাধ্যমে আমরা যেকোনো সারি কে ইউনিক ভাবে সিলেক্ট করে বিভিন্ন অপারেশন যেমনঃ Delete, Update ইত্যাদি করতে পারব। যেমনঃ

```
DELETE products WHERE product_id = 10;

UPDATE products SET price = 800
WHERE product_id = 5;
```

আমরা products এর অন্য property বা attribute যেমনঃ title এর মাধ্যমে কিন্তু ইউনিকভাবে অপারেশন চালাতে পারব না, কারন একাধিক টাইটেল একরকম থাকতে পারে।

```
CREATE TABLE orders(
    order_id INT SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    total_price NUMERIC(10,2)
)
```

এখানে একটি orders টেবিল যার প্রাইমারি কী হচ্ছে order_id, যার মাধ্যমে আমরা order টেবিলের যেকোনো একটি রেকর্ডের উপর অপারেশন করতে পারব এবং foreign key হচ্ছে product_id। কারন product_id, products টেবিলে প্রাইমারি কী।

এই product_id ফরেন কী এর মাধ্যমে কোন product অডার করা হয়েছিল তা বুঝতে ও product এর info গুলোও product টেবিল থেকে প্রয়োজনমত আনতে পারব। যেহেতু প্রতিটি order নির্দিষ্ট product এর সাথে সম্পর্ক সৃষ্টি করে। ফলে, product এর তথ্য গুলো ও order টেবিলে সংরক্ষণ করতে হল না।

## 2. What is the difference between the VARCHAR and CHAR data types?

VARCHAR ও CHAR এর মধ্যে পার্থক্য হল VARCHAR datatype এর মধ্যে যতটুকু জায়গা লাগে ততটুকু জায়গা নিয়ে ক্যারেক্টার ডাটা স্টোর করে অর্থাৎ পরিবর্তনশীল, অন্যদিকে CHAR datatype ফিক্সড-লেন্থ, সবসময় একই লেন্থ এর ডাটা স্টোর করে। যেমনঃ

```
title VARCHAR(50)

status CHAR(4)
```

এখানে title ‍সর্বোচ্চ 50 টি ক্যারেক্টার স্টোর করতে পারবে, আর title যদি আরো ছোট হয়, তাহলে কম জায়গা নিবে।

অপরপক্ষে, ‍ status পুরো জায়গা নিবে। যদি ‍ status গুলো একই লেন্থ এর হয় বা আমরা জানি কয়টি ক্যারেক্টার হবে, তাহলে আমরা CHAR datatype ব্যবহৃত করব।

question-3

## 3. Explain the purpose of the WHERE clause in a SELECT statement.

SELECT statement এর সাথে WHERE clause ব্যবহার করে , আমরা শর্তসাপেক্ষে ডাটা এর উপর ফিল্টার বা অপারেশন করতে পারি। যেমনঃ

```
SELECT * FROM products
WHERE price < 800;

```

এর মাধ্যমে সব products না দেখিয়ে শুধু ঐ সব product দেখাবে যেগুলোর মূল্য 800 থেকে ‍ কম।

```
SELECT * FROM products
WHERE price > 2000;
```

এর মাধ্যমে ঐ সব product দেখাবে যেগুলোর মূল্য 2000 থেকে ‍ বেশি। অর্থাৎ WHERE এর পরের শর্ত (price>2000) মেনে চলে।

```
SELECT * FROM products
WHERE catgory = 'food';

```

এই কমান্ড এর মাধ্যমে যে product গুলোর ক্যাটাগরি food শুধু ঐগুলো দেখাবে।

## 4. What are the LIMIT and OFFSET clauses used for?

LIMIT ও OFFSET, এস কিউ এল কোয়েরি গুলোর রিটার্ন করা রো (ROW) গুলোর ‍সীমাবদ্ধতা বা নিয়ন্ত্রণ করতে ব্যবহৃত হয়।

LIMIT ঃ এর মাধ্যমে আমরা কতগুলো সারি বা রেকর্ড দেখতে চাই, তা ডিফাইন করে দিতে পারি। যেমনঃ

```
SELECT * FROM products
LIMIT 20;

```

উপরের কমান্ড এর মাধ্যমে শুধু 20 টা products দেখাবে। যেহেতু LIMIT আমরা 20 সেট করে ‍দিয়েছি।

OFFSET ঃ এর মাধ্যমে আমরা প্রথম কতগুলো সারি বা রেকর্ড স্কিপ (SKIP) করতে চাই, তা ডিফাইন করে দিতে পারি। যেমনঃ

```
SELECT * FROM products
OFFSET 50;

```

উপরের কমান্ড এর মাধ্যমে প্রথম 50 টা products বাদ দিয়ে বাকিগুলো দেখাবে। যেহেতু OFFSET আমরা 50 সেট করে ‍দিয়েছি।

offset ও limit একসাথে ব্যবহার করে আমরা প্রত্যাশিত আউইপুট আনতে পারি।

```
SELECT * FROM products
OFFSET 10 LIMIT 20;

```

এই কমান্ডের মাধ্যমে প্রথম 10 টা স্কিপ করে পরের থেকে মোট 20 টা product রিটার্ন করবে।

## 5. How can you modify data using UPDATE statements?

UPDATE এর মাধ্যমে খুব সহজেই ডাটা মডিফাই করা যায়।

সিনটেক্স ঃ

```
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...

WHERE conditions;
```

আমরা একসাথে একাধিক কলামের ভ্যালু মডিফাই করতে পারি অথবা একাধিক রো তে আপডেট করতে পারি শর্তসাপেক্ষে ।

আমরা যদি একটি প্রোডাক্টের প্রাইস 1000 করতে চাই, যার product_id হচ্ছে 10, তাহলে কমান্ডটি হবে নিম্নরুপঃ

```
UPDATE products
SET price = 1000
WHERE product_id = 10;

```

আমরা যদি সব প্রোডাক্টের প্রাইস 0 করতে চাই, যাদের product_id হচ্ছে 70 এর উপরে এবং 90 এর নিচে, তাহলে কমান্ডটি হবে নিম্নরুপঃ

```
UPDATE products
SET price = 0
WHERE product_id > 70 ‍AND product_id < 90;

```

তবে মনে রাখতে হবে যে, যদি where clause না দিই, তাহলে সব রো আপডেট হয়ে যাবে।

```
UPDATE products
SET price = 50

```

এর মাধ্যমে যত প্রোডাক্ট আছে সবটার price হয়ে যাবে 50।
