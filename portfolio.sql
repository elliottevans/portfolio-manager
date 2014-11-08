/*
Elliott Evans
Tim Sullivan
11/8/2014


This is the SQL DDL for Portfolio project B. 
It creates all of the necessary tables for 
the project while identifying keys and restraints
from the E/R Design.
*/


create table users (
--This is the table containing all of the users in the system.

--Each user must have a name, and a unique one

  name varchar(64) not null primary key,

--Each user must have a password of at least 8 characters

  password varchar(64) not null,
    constraint long_passwd CHECK (password LIKE '________%'),

--Each user must have a unique email address, checks to see if
--there is an "@" in the name

  email varchar(256) not null UNIQUE 
    constraint email_ok CHECK (email LIKE '%@%'),
)

create table owned_by(
--This table associates users with their portfolios.

--To associate users with their portfolios, each owned_by table
--has a user name that must exist in the users table

  user_name varchar(64) not null references users(name),

--Each user identified by his name and email, so we include user's
--email in this table

  user_email varchar(256) not null references users(email),

--Each portfolio has an id that's at least 8 characers long.

  portfolio_id integer not null references portfolios(id)     
)

create table portfolios(
--This is the table of every portfolio that is owned by every user.

--Each portfolio has an id that uniquely identifies it.

  id integer not null primary key,

--Each portfolio has an associated cash amount

  cash_amount integer not null
)

create table holdings_of(
--The holdings_of table associates a portfolio with its holdings.
--i.e. if we want to know what stocks are in a portfolio,

--Each portfolio has several stocks 

  stock_id integer not null references stocks(id),

--Each portfolio has a unique id.
  portfolio_id integer not null references portfolios(id) primary key,
)

create table stocks(
--This is a list of stocks to use with holdings_of. 
--If anyone has a share of any stock, it will be here.
--So, if different users have shares of the same stock,
--that stock will show up twice in this table, once with
--one user's shares and again with the other user's shares.
--This is why the symbol will not be the primary key.
--Similarly, two people can have the same number of shares
--of a stock. Instead we uniquely identify a stock and
--its shares with an id.

--Every stock has a unique id.

  id integer not null primary key,

--Each stock has a number of shares owne by a user 

  shares integer not null,

--A stock has a symbol

  symbol varchar(16) not null
)

create table dailies(
--This is a list of daily information on every stock.

--Each daily uniquely identified by its timestamp

  time_stamp integer not null primary key,

--Each daily has a stock symbol that should reference a not null 
--value from stocks	

  stock_symbol varchar(16) not null references stock(symbol),

--Strike prie of the first trade of the day

  open integer not null,

--Highest strike price during the day

  high integer not null,

--Lowest strike price during the day

  low integer not null,

--Strike price of the last trade of the day

  close integer not null,

--Total number of shares traded during the day

  volume integer not null
)

