CREATE TABLE IF NOT EXISTS public.shops (
	shop_id SERIAL PRIMARY KEY,
	shop_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.products (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	price NUMERIC(6, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.plan (
	product_id INTEGER NOT NULL,
	shop_id INTEGER NOT NULL,
	plan_cnt INTEGER NOT NULL,
	plan_date DATE NOT NULL,
	FOREIGN KEY (product_id) REFERENCES public.products(product_id),
	FOREIGN KEY (shop_id) REFERENCES public.shops(shop_id)
);

CREATE TABLE IF NOT EXISTS public.shop_dns (
	"date" DATE NOT NULL DEFAULT CURRENT_DATE,
	product_id INTEGER NOT NULL,
	sales_cnt INTEGER NOT NULL,
	FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE IF NOT EXISTS public.shop_mvideo (
	"date" DATE NOT NULL DEFAULT CURRENT_DATE,
	product_id INTEGER NOT NULL,
	sales_cnt INTEGER NOT NULL,
	FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE TABLE IF NOT EXISTS public.shop_sitilink (
	"date" DATE NOT NULL DEFAULT CURRENT_DATE,
	product_id INTEGER NOT NULL,
	sales_cnt INTEGER NOT NULL,
	FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);


INSERT INTO public.shops (shop_name)
VALUES ('dns'), ('mvideo'), ('sitilink');

INSERT INTO public.products (product_name, price)
VALUES('Broken phone', 1000), ('Word of mouth', 2999.99), ('Turntable', 4999.49);

INSERT INTO public.plan
(product_id, shop_id, plan_cnt, plan_date)
VALUES(1, 1, 10, '2023-07-31'),
      (2, 1, 6, '2023-07-31'),
      (3, 1, 7, '2023-07-31'),
      (1, 2, 20, '2023-07-31'),
      (3, 2, 15, '2023-07-31'),
      (2, 3, 30, '2023-07-31');

INSERT INTO public.shop_dns
("date", product_id, sales_cnt)
VALUES('2023-07-10', 1, 4),
      ('2023-07-12', 3, 1),
      ('2023-07-15', 1, 6),
      ('2023-07-15', 2, 2),
      ('2023-07-23', 1, 2),
      ('2023-07-26', 3, 2),
      ('2023-07-29', 2, 5);

INSERT INTO public.shop_mvideo
("date", product_id, sales_cnt)
VALUES('2023-07-10', 1, 10),
      ('2023-07-10', 3, 4),
      ('2023-07-16', 3, 2),
      ('2023-07-20', 1, 4),
      ('2023-07-20', 3, 6),
      ('2023-07-27', 3, 7),
      ('2023-07-29', 1, 5);

INSERT INTO public.shop_sitilink
("date", product_id, sales_cnt)
VALUES('2023-07-15', 2, 10),
      ('2023-07-20', 2, 10),
      ('2023-07-29', 2, 10);