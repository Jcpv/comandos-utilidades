AL PASAR A OJS 3.2, Se requiere de la siguiente tabla

CREATE TABLE citations_publication_seq (
    publication_id INT(11) NOT NULL,
    citation_seq INT(11) NOT NULL,
    PRIMARY KEY (publication_id, citation_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;