-- CREATE NEW TABLE

CREATE TABLE patients (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(50),
  FOREIGN KEY (patient_id) REFERENCES patients (id) ON DELETE CASCADE
);

CREATE TABLE treatments (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(50),
  name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS public.invoice_items
(
    id integer NOT NULL,
    unit_price numeric NOT NULL,
    quantity integer NOT NULL,
    total_price numeric NOT NULL,
    invoice_id integer NOT NULL,
    treatment_id integer NOT NULL,
    CONSTRAINT invoice_items_pkey PRIMARY KEY (id),
    CONSTRAINT invoice_id FOREIGN KEY (invoice_id)
        REFERENCES public.invoices (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT treatment_id FOREIGN KEY (treatment_id)
        REFERENCES public.treatments (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice_items
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.invoices
(
    id integer NOT NULL,
    total_amount numeric NOT NULL,
    generate_at timestamp with time zone NOT NULL,
    payed_at timestamp with time zone NOT NULL,
    medical_histories_id integer NOT NULL,
    CONSTRAINT invoices_pkey PRIMARY KEY (id),
    CONSTRAINT medical_histories_id FOREIGN KEY (medical_histories_id)
        REFERENCES public.medical_histories (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoices
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public."joinTable"
(
    medical_histories_id integer NOT NULL,
    treatment_id integer NOT NULL,
    CONSTRAINT medical_histories_id FOREIGN KEY (medical_histories_id)
        REFERENCES public.medical_histories (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT treatment_id FOREIGN KEY (treatment_id)
        REFERENCES public.treatments (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."joinTable"
    OWNER to postgres;