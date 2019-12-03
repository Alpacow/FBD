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

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CURSO_TURMA (
    ID_CURSO_TURMA int primary key,
    NOME_TURMA varchar,
    SIGLA_CURSO varchar,
	NOME_CURSO varchar
);

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DISCIPLINA_TURMA (
    ID_DISCIPLINA int primary key,
	CODIGO varchar, -- elc1069
    NOME_DISC varchar,
    NOME_TURMA varchar
);

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TURMA_DISCIPLINA (
    ID_TURMA int primary key,
	NOME_TURMA varchar,
    NOME_DISCIPLINA varchar
);

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.PESSOA_DISCIPLINA (
	MATRICULA varchar,
	CODIGO_DISC varchar,
	NOME varchar,
	ATIVO boolean,
	ALUNO_PROFESSOR varchar,
	PRIMARY KEY((MATRICULA), CODIGO_DISC, NOME)
);

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.DISCIPLINA_PESSOA (
	CODIGO_DISC varchar,
	MATRICULA varchar,
	NOME_PESSOA varchar,
	PRIMARY KEY((MATRICULA), CODIGO_DISC)
);

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.DIARIO (
	NOME_PESSOA varchar,
	CODIGO_DISC varchar,
    DATA_HORA timestamp,
    PRESENCA varchar,
    PRIMARY KEY((NOME_PESSOA), CODIGO_DISC, DATA_HORA)
);

-----------------------------------------------------------------------------------------