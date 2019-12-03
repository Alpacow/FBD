-- to run: ./bin/cqlsh
-- SOURCE '/caminhoArquivo/arquivo.cql' -> SOURCE '/home/flan/Documents/UFSM/FBD/Trabalho/DiarioBD.cql'

CREATE KEYSPACE IF NOT EXISTS fbd WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};

USE fbd;

CREATE TABLE IF NOT EXISTS TURMA (
	ID_TURMA int, -- PK
    NOME_TURMA varchar,
    PERIODO varchar,
    TURNO varchar,
	PRIMARY KEY((ID_TURMA), NOME_TURMA)
);

COPY TURMA (
	ID_TURMA, 
	NOME_TURMA, 
	PERIODO, 
	TURNO
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/TURMA.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CURSO_TURMA (
    ID_CURSO_TURMA int primary key,
    NOME_TURMA varchar,
    SIGLA_CURSO varchar,
	NOME_CURSO varchar
);

COPY CURSO_TURMA (
	ID_CURSO_TURMA, 
	NOME_TURMA, 
	SIGLA_CURSO, 
	NOME_CURSO
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/CURSO_TURMA.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DISCIPLINA_TURMA (
    ID_DISCIPLINA int primary key,
	CODIGO varchar, -- elc1069
    NOME_DISC varchar,
    NOME_TURMA varchar
);

COPY DISCIPLINA_TURMA (
	ID_DISCIPLINA, 
	CODIGO, 
	NOME_DISC, 
	NOME_TURMA
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/DISCIPLINA_TURMA.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TURMA_DISCIPLINA (
    ID_TURMA int primary key,
	NOME_TURMA varchar,
    NOME_DISCIPLINA varchar
);

COPY TURMA_DISCIPLINA (
	ID_TURMA, 
	NOME_TURMA, 
	NOME_DISCIPLINA
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/TURMA_DISCIPLINA.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS fbd.PESSOA_DISCIPLINA (
	MATRICULA varchar,
	CODIGO_DISC varchar,
	NOME varchar,
	ATIVO boolean,
	ALUNO_PROFESSOR varchar,
	PRIMARY KEY((MATRICULA), CODIGO_DISC, NOME)
);

COPY PESSOA_DISCIPLINA (
	MATRICULA, 
	CODIGO_DISC, 
	NOME, 
	ATIVO,
	ALUNO_PROFESSOR
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/PESSOA_DISCIPLINA.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS fbd.DISCIPLINA_PESSOA (
	CODIGO_DISC varchar,
	MATRICULA varchar,
	NOME_PESSOA varchar,
	PRIMARY KEY((MATRICULA), CODIGO_DISC)
);

COPY DISCIPLINA_PESSOA (
	CODIGO_DISC, 
	MATRICULA, 
	NOME_PESSOA
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/DISCIPLINA_PESSOA.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.DIARIO (
	NOME_PESSOA varchar,
	CODIGO_DISC varchar,
    DATA_HORA timestamp,
    PRESENCA varchar,
    PRIMARY KEY((NOME_PESSOA), CODIGO_DISC, DATA_HORA)
);

COPY DIARIO (
	NOME_PESSOA, 
	CODIGO_DISC, 
	DATA_HORA, 
	PRESENCA
) FROM './../../../Users/augus/Desktop/FBD/Trabalho/CSVs/DIARIO.csv' WITH DELIMITER=',' AND HEADER=TRUE;

-----------------------------------------------------------------------------------------