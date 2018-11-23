create table Todo (
    id int not null AUTO_INCREMENT,
    name varchar(250) not null,
    done boolean DEFAULT FALSE,
    PRIMARY KEY (id)
);