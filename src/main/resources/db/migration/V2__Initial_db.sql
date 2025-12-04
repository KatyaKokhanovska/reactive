-- ============================
-- Table: reader
-- ============================
create table reader (
                        id          bigserial primary key,
                        first_name  varchar(255) not null,
                        last_name   varchar(255) not null,
                        email       varchar(255) unique not null,
                        address     varchar(255)
);

-- ============================
-- Table: publication
-- ============================
create table publication (
                             id              bigserial primary key,
                             title           varchar(255) not null,
                             category        varchar(255),
                             description     text,
                             monthly_price   numeric(10,2) not null
);

-- ============================
-- Table: subscription
-- ============================
create table subscription (
                              id              bigserial primary key,
                              reader_id       bigint not null,
                              publication_id  bigint not null,
                              months          int not null,
                              total_price     numeric(10,2) not null,
                              start_date      date not null,

                              constraint fk_subscription_reader
                                  foreign key (reader_id)
                                      references reader(id)
                                      on delete cascade,

                              constraint fk_subscription_publication
                                  foreign key (publication_id)
                                      references publication(id)
                                      on delete cascade
);

-- ============================
-- Table: payment
-- ============================
create table payment (
                         id               bigserial primary key,
                         subscription_id  bigint not null,
                         amount           numeric(10,2) not null,
                         payment_date     timestamp not null,
                         status           varchar(255) not null,

                         constraint fk_payment_subscription
                             foreign key (subscription_id)
                                 references subscription(id)
                                 on delete cascade
);
