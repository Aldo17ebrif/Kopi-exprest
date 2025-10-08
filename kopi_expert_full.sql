-- kopi_expert_full.sql
CREATE DATABASE IF NOT EXISTS kopi_expert;
USE kopi_expert;

CREATE TABLE IF NOT EXISTS pref (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(30) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS kopi (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(30) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  recipe TEXT,
  description TEXT
);

CREATE TABLE IF NOT EXISTS rule_base (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(30) UNIQUE,
  name VARCHAR(255),
  required_prefs TEXT,
  confidence DECIMAL(4,3) DEFAULT 1.000,
  kopi_id INT NOT NULL,
  FOREIGN KEY (kopi_id) REFERENCES kopi(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS konsultasi (
  id INT AUTO_INCREMENT PRIMARY KEY,
  session_token VARCHAR(64),
  user_name VARCHAR(100),
  selected_prefs TEXT,
  recommended TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PREF data
INSERT INTO pref (code,name,description) VALUES
('P_BITTER','Suka rasa pahit','Preferensi rasa pahit/pekatan kopi (tanpa pemanis)'),
('P_SWEET','Suka rasa manis','Suka kopi manis / tambahan gula/sirup'),
('P_ACID','Suka rasa asam','Preferensi aroma/asam buah (bright acidity)'),
('P_LOW_ACID','Tidak suka asam','Sensitif terhadap asam, pilih kopi low-acid'),
('P_BODY_HEAVY','Suka body penuh','Menginginkan mouthfeel kental/berbodi'),
('P_BODY_LIGHT','Suka body ringan','Suka kopi ringan / clean mouthfeel'),
('P_STRONG','Suka kopi kuat','Ingin kandungan kafein/ekstraksi kuat'),
('P_MILD','Suka kopi ringan','Tidak suka terlalu pekat'),
('P_COLD','Suka kopi dingin/es','Preferensi minuman dingin / iced drinks'),
('P_HOT','Suka kopi panas','Preferensi minuman panas'),
('P_MILK','Suka ada susu','Suka campuran susu (latte, cappuccino, dsb)'),
('P_NO_DAIRY','Tidak mau susu/dairy','Alergi / prefer non-dairy'),
('P_CHOCOLATE','Suka rasa cokelat','Menyukai profil cokelat/karamel'),
('P_NUTTY','Suka rasa kacang/nutty','Profil rasa kacang / almond / hazelnut'),
('P_FRUITY','Suka rasa buah','Menyukai kopi dengan notes buah (berry, citrus)'),
('P_SMOKY','Suka rasa smoky','Menyukai rasa asap/roast deep'),
('P_SPICY','Suka rempah','Suka jahe, kayu manis, cardamom dalam kopi'),
('P_SWEETENER_PALM','Suka gula aren / gula merah','Prefer sweetener jenis gula aren/gula merah'),
('P_LOW_CAL','Ingin rendah kalori','Kurangi susu full-cream & gula'),
('P_COFFEE_ALONE','Suka espresso/shot saja','Prefer straight espresso tanpa tambahan'),
('P_CREATIVE','Suka signature/unik','Mencari minuman unik/kreasi lokal'),
('P_FROTH','Suka foam/tekstur busa','Menikmati foam tebal atau microfoam'),
('P_CREAMY','Suka creamy','Tekstur lembut & creamy'),
('P_COLD_EXTRACTION','Suka profil cold-brew','Suka body halus & rendah asam (cold brew)'),
('P_NITRO','Suka nitro / sparkling cold coffee','Menyukai nitro atau kopi berkarbonasi halus'),
('P_DECAF','Butuh decaf / low caffeine','Tidak mau kafein tinggi'),
('P_SUGAR_HEAVY','Suka manis sangat','Prefer manis sangat (dessert-like)'),
('P_TRADITIONAL','Suka kopi tradisional lokal','Prefer gaya tradisional (tubruk, gula aren, rempah)');

-- KOPI data (28 items)
INSERT INTO kopi (code,name,recipe,description) VALUES
('C01','Espresso','18-20g fine grind, ekstrak 25-30 ml (25-30 detik)','Pekat, konsentrat, dasar berbagai minuman kopi'),
('C02','Ristretto','18g, ekstraksi 15-20 ml','Lebih pekat dari espresso, body penuh'),
('C03','Americano','1 shot espresso + 120-150 ml air panas','Kopi encer berbasis espresso'),
('C04','Latte','1 shot espresso + 200 ml susu panas + microfoam','Creamy, susu dominan'),
('C05','Cappuccino','1 shot espresso + 100 ml susu + 100 ml foam','Seimbang espresso-susu-foam'),
('C06','Flat White','1-2 shot espresso + 150 ml susu microfoam','Microfoam halus, kopi terasa kuat'),
('C07','Cortado','1 shot espresso + 30-60 ml susu panas','Espresso + sedikit susu, seimbang'),
('C08','Macchiato','1 shot espresso + sedikit foam/susu','Espresso dengan \"titik\" susu/foam'),
('C09','Mocha','Espresso + cokelat + susu panas','Kopi-cokelat, manis & creamy'),
('C10','Affogato','Shot espresso dituang di atas scoop es krim vanila','Dessert: kopi + es krim'),
('C11','Lungo','Ekstraksi lebih panjang, 60-90 ml','Versi panjang espresso'),
('C12','Cold Brew','Cold steep 8-12 jam, coarse grind','Rendah asam, halus, berbodi'),
('C13','Nitro Cold Brew','Cold brew + infus nitrogen','Creamy, foamy tanpa susu'),
('C14','Es Kopi Susu','Strong brew/espresso + susu + es','Manis, populer, sering memakai susu kental manis'),
('C15','Kopi Tubruk','Kopi bubuk dituang air panas, diaduk; bisa gula aren','Tradisional Indonesia, pekat'),
('C16','Kopi Gayo (Aceh)','Specialty bean Gayo; brew pour-over','Fruity, floral tergantung roast'),
('C17','Kopi Toraja','Sulawesi, earthy & chocolate notes','Full-bodied, sedikit fruity atau smoky'),
('C18','Kopi Mandailing','Sumatra, low acidity, chocolatey','Full-bodied, cocok tubruk atau espresso blend'),
('C19','Kopi Kintamani (Bali)','Bright acidity, citrus notes','Light–medium body, fruity'),
('C20','Kopi Luwak','Biji spesial, aroma kompleks','Premium, aroma kompleks dan halus'),
('C21','Kopi Jahe','Kopi + jahe segar + gula aren (opsional)','Hangat, rempah, tradisional nikmat'),
('C22','Kopi Rempah','Kopi + cardamom/kayu manis/kapulaga','Rempah aromatik, cocok untuk pecinta spicy'),
('C23','Kopi Aren','Kopi tubruk + gula aren/gula merah','Manis karamel khas gula aren'),
('C24','Es Kopi Vietnam','Strong brew + susu kental manis + es','Sangat manis & pekat, gaya Vietnam'),
('C25','Kopi Susu Salted Caramel','Espresso + susu + caramel + salted topping','Signature dessert-like'),
('C26','Kopi Papua (Robusta blend)','Robusta local blend, kuat & earthy','Robusta kuat, sering dipadukan gula lokal'),
('C27','Kopi Pandan','Kopi + ekstrak pandan atau rebusan pandan','Aromatik pandan + kopi'),
('C28','Decaf Latte','1 shot decaf espresso + susu','Creamy, rendah kafein');

-- RULES (45 entries)
INSERT INTO rule_base (code, name, required_prefs, confidence, kopi_id) VALUES
('R01','Pecinta Pahit & Kuat','1,7',0.98,1),
('R02','Pecinta Pekat tapi Medium Body','1,5,7',0.95,2),
('R03','Kopi Encer Panas','3,10',0.75,3),
('R04','Suka Susu Creamy','11,23',0.94,4),
('R05','Suka Foam Tebal','22,11',0.92,5),
('R06','Suka Microfoam & Kopi Kuat','22,7',0.90,6),
('R07','Sedikit Susu, Espresso Forward','11,20',0.88,7),
('R08','Shot with Tiny Milk','20,22',0.86,8),
('R09','Suka Cokelat + Susu','13,11',0.93,9),
('R10','Pencinta Dessert Espresso','20,27',0.85,10),
('R11','Suka Ekstraksi Panjang','1,11',0.70,11),
('R12','Suka Dingin, Low Acidity','9,24',0.97,12),
('R13','Ingin Nitro Creamy Dingin','9,24,25',0.98,13),
('R14','Kopi Susu Manis Dingin','9,2,14',0.94,14),
('R15','Kopi Tradisional Pekat','15,10,28',0.96,15),
('R16','Suka Specialty Aceh Gayo Fruity','15,3,16',0.92,16),
('R17','Suka Earthy Chocolate Sulawesi','5,13,17',0.91,17),
('R18','Suka Full Body & Low Acid','5,4,18',0.90,18),
('R19','Suka Bright & Citrus Bali Kintamani','3,6,19',0.89,19),
('R20','Premium Aroma Kompleks','1,5,20',0.88,20),
('R21','Hangat & Rempah (Jahe)','10,17,21',0.95,21),
('R22','Rempah Aromatik','17,22',0.88,22),
('R23','Gula Aren Traditional','18,15,28',0.96,23),
('R24','Vietnamese Sweet Iced','24,2,9',0.97,24),
('R25','Karamel + Salted Signature','2,25,11',0.90,25),
('R26','Robusta Papua, Strong & Earthy','7,5,26',0.92,26),
('R27','Aromatic Pandan Fusion','21,27',0.87,27),
('R28','Decaf Creamy','26,11,23',0.93,28),
('R29','Suka Manis Tinggi dan Dessert','2,27',0.88,14),
('R30','Suka Manis Sangat + Karakter Cokelat','2,13',0.86,9),
('R31','Low Acid tapi Ingin Milk','4,11',0.82,28),
('R32','Suka Cold & Manis Palm Sugar','9,18',0.90,23),
('R33','Suka Fruity & Light Body','15,6',0.90,16),
('R34','Suka Nutty & Creamy','14,23',0.88,4),
('R35','Suka Smoky Heavy Roast','16,1',0.91,17),
('R36','Suka Low Cal & No Dairy','19,12',0.85,3),
('R37','Suka Kopi Tradisi + Gula Aren','28,18',0.96,15),
('R38','Suka Cold Brew tapi Low Acidity','24,4',0.95,12),
('R39','Suka Nitro & Smooth tanpa Milk','25,24,12',0.97,13),
('R40','Suka Espresso Shot Tapi Creamy','20,23',0.88,8),
('R41','Suka Signature Lokal & Unik','21,28',0.89,27),
('R42','Suka Rempah & Sweet Palm','17,18',0.92,23),
('R43','Suka Kopi Kuat + No Dairy','7,12',0.87,3),
('R44','Suka Milk & Chocolate tapi No Dairy','13,12',0.62,9),
('R45','Pencari Pengalaman Premium Lokal','21,20',0.90,20);

-- end of SQL
