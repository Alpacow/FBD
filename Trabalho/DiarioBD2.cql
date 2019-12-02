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
INSERT INTO fbd.turma (ID_TURMA, NOME_TURMA, PERIODO, TURNO)
	VALUES (1, 'CC1', '2019/2', 'Tarde');
INSERT INTO fbd.turma (ID_TURMA, NOME_TURMA, PERIODO, TURNO)
	VALUES (2, 'SI1', '2019/2', 'Manha');

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CURSO_TURMA (
    ID_CURSO_TURMA int primary key,
    NOME_TURMA varchar,
    SIGLA_CURSO varchar,
	NOME_CURSO varchar
);
INSERT INTO fbd.curso_turma (ID_CURSO_TURMA, NOME_TURMA, SIGLA_CURSO, NOME_CURSO)
	VALUES (1, 'CC1', 'CC', 'Ciencia da Comptuaçao');
INSERT INTO fbd.curso_turma (ID_CURSO_TURMA, NOME_TURMA, SIGLA_CURSO, NOME_CURSO)
	VALUES (2, 'SI1', 'CC', 'Ciencia da Comptuaçao');

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DISCIPLINA_TURMA (
    ID_DISCIPLINA int primary key,
	CODIGO varchar, -- elc1069
    NOME_DISC varchar,
    NOME_TURMA varchar
);
INSERT INTO fbd.disciplina_turma (ID_DISCIPLINA, CODIGO, NOME_DISC, NOME_TURMA)
	VALUES (1, 'ELC1069', 'Fundamentos de Banco de Dados', 'CC1');
INSERT INTO fbd.disciplina_turma (ID_DISCIPLINA, CODIGO, NOME_DISC, NOME_TURMA)
	VALUES (2, 'MTM1021', 'Metodos Numericos Computacionais', 'CC1');

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TURMA_DISCIPLINA (
    ID_TURMA int primary key,
	NOME_TURMA varchar,
    NOME_DISCIPLINA varchar
);
INSERT INTO fbd.turma_disciplina (ID_TURMA, NOME_TURMA, NOME_DISCIPLINA)
	VALUES (1, 'CC1', 'Fundamentos de Banco de Dados');
INSERT INTO fbd.turma_disciplina (ID_TURMA, NOME_TURMA, NOME_DISCIPLINA)
	VALUES (2, 'CC1', 'Metodos Numericos Computacionais');

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.PESSOA_DISCIPLINA (
	MATRICULA varchar,
	CODIGO_DISC varchar,
	NOME varchar,
	ATIVO boolean,
	ALUNO_PROFESSOR varchar,
	PRIMARY KEY((MATRICULA), CODIGO_DISC, NOME)
);
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201811985', 'ELC1069', 'Francielle Vasconcellos Pereira', True, 'A');
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201511685', 'ELC1069', 'Rafael Portuga', True, 'A');
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201810805', 'ELC1069', 'Elizabeth Nozweg', True, 'A');
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201011985', 'ELC1069', 'Caio Damasceno', True, 'P');
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201010985', 'MTM1021', 'Pedro Gonçalves', True, 'P');
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201811985', 'MTM1021', 'Francielle Vasconcellos Pereira', True, 'A');
INSERT INTO fbd.PESSOA_DISCIPLINA (MATRICULA, CODIGO_DISC, NOME, ATIVO, ALUNO_PROFESSOR)
	VALUES ('201808985', 'MTM1021', 'Augusto Gai Dalasta', True, 'A');

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.DISCIPLINA_PESSOA (
	CODIGO_DISC varchar,
	MATRICULA varchar,
	NOME_PESSOA varchar,
	PRIMARY KEY((MATRICULA), CODIGO_DISC)
);
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('MTM1021', '201808985', 'Augusto Gai Dalasta');
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('MTM1021', '201811985', 'Francielle Vasconcellos Pereira');
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('MTM1021', '201010985', 'Pedro Gonçalves');
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('ELC1069', '201011985', 'Caio Damasceno');
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('ELC1069', '201810805', 'Elizabeth Nozweg');
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('ELC1069', '201511685', 'Rafael Portuga');
INSERT INTO fbd.DISCIPLINA_PESSOA (CODIGO_DISC, MATRICULA, NOME_PESSOA)
	VALUES ('ELC1069', '201811985', 'Francielle Vasconcellos Pereira');

-----------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS fbd.DIARIO (
	NOME_PESSOA varchar,
	CODIGO_DISC varchar,
    DATA_HORA timestamp,
    PRESENCA varchar,
    PRIMARY KEY((NOME_PESSOA), CODIGO_DISC, DATA_HORA)
);
INSERT INTO fbd.DIARIO (NOME_PESSOA, CODIGO_DISC, DATA_HORA, PRESENCA)
	VALUES ('Francielle Vasconcellos Pereira', 'ELC1069', '2019-11-29 10:50:00', 'P');
INSERT INTO fbd.DIARIO (NOME_PESSOA, CODIGO_DISC, DATA_HORA, PRESENCA)
	VALUES ('Rafael Portuga', 'MTM', '2019-11-29 10:50:00', 'F');
INSERT INTO fbd.DIARIO (NOME_PESSOA, CODIGO_DISC, DATA_HORA, PRESENCA)
	VALUES ('Elizabeth Nozweg', 'MTM', '2019-11-29 10:50:00', 'P');

INSERT INTO fbd.DIARIO (NOME_PESSOA, CODIGO_DISC, DATA_HORA, PRESENCA)
	VALUES ('Francielle Vasconcellos Pereira', 'ELC1069', '2019-12-01 10:50:00', 'P');
INSERT INTO fbd.DIARIO (NOME_PESSOA, CODIGO_DISC, DATA_HORA, PRESENCA)
	VALUES ('Rafael Portuga', 'MTM', '2019-12-01 10:50:00', 'P');
INSERT INTO fbd.DIARIO (NOME_PESSOA, CODIGO_DISC, DATA_HORA, PRESENCA)
	VALUES ('Elizabeth Nozweg', 'MTM', '2019-12-01 10:50:00', 'P');
-----------------------------------------------------------------------------------------