CREATE TYPE role AS ENUM ('admin', 'reservations', 'host');
CREATE TYPE state_of_pay AS ENUM ('paid', 'no_paid', 'deposit');
CREATE TYPE state_of_reservation AS ENUM ('created', 'checked_in', 'checked_out', 'cancelled');

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    role role NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    password_hash VARCHAR(150) NOT NULL,
    username VARCHAR(150) UNIQUE NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE room_types (
    id SERIAL PRIMARY KEY,
    category VARCHAR (100) NOT NULL,
    max_capacity INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE guests (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    identification VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    mail VARCHAR(255)
);

CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    number INTEGER UNIQUE NOT NULL,
    room_type_id INTEGER NOT NULL REFERENCES room_types(id),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    guest_id INTEGER NOT NULL REFERENCES guests(id),
    room_id INTEGER REFERENCES rooms(id),
    room_type_id INTEGER NOT NULL REFERENCES room_types(id),
    entry_date DATE NOT NULL,
    departure_date DATE NOT NULL,
    guest_count INTEGER NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    payment_due_date DATE,
    pay_status state_of_pay NOT NULL DEFAULT 'no_paid',
    reservation_status state_of_reservation NOT NULL DEFAULT 'created' 
);
