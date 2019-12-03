-- to run: ./bin/cqlsh
-- SOURCE '/caminhoArquivo/arquivo.cql' -> SOURCE '/home/flan/Documents/UFSM/FBD/Trabalho/DiarioBD.cql'

CREATE KEYSPACE IF NOT EXISTS fbd WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};

USE fbd;

CREATE TABLE IF NOT EXISTS PESSOA (
	ID int primary key,
	MATRICULA varchar,
	NOME varchar,
	ATIVO boolean,
	ALUNO_PROFESSOR varchar
);
	
CREATE TABLE IF NOT EXISTS CURSO (
	ID_CURSO int primary key,
	SIGLA varchar,
	NOME_CURSO varchar
);

CREATE TABLE IF NOT EXISTS DISCIPLINA (
	CODIGO varchar primary key, -- elc1069
    NOME_DISC varchar
);

CREATE TABLE IF NOT EXISTS TURMA (
	ID_TURMA int, -- PK
    NOME_TURMA varchar,
    PERIODO varchar,
    TURNO varchar,
    ID_CURSO int,
	PRIMARY KEY((ID_TURMA), ID_CURSO) -- FOREIGN KEY (ID_CURSO) REFERENCES CURSO(ID_CURSO)
);

CREATE TABLE IF NOT EXISTS DISCIPLINA_TURMA(
	ID_DISC_TURMA int, -- PK
    ID_DISCIPLINA varchar, -- FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINA(CODIGO)
    ID_PROFESSOR int, -- FOREIGN KEY (ID_PROFESSOR) REFERENCES PESSOA(ID)
    ID_TURMA int, -- FOREIGN KEY (ID_TURMA) REFERENCES TURMA(ID_TURMA)
    CARGA_HORARIA int,
    NR_VAGAS int,
	PRIMARY KEY((ID_DISC_TURMA), ID_DISCIPLINA, ID_PROFESSOR, ID_TURMA)
);

select * from fbd.pessoa;
select * from fbd.disciplina_turma;
CREATE TABLE IF NOT EXISTS DIARIO(
	ID_ALUNO int, -- FOREIGN KEY (ID_ALUNO) REFERENCES ALUNO_TURMA(ID_ALUNO)
    ID_DISCIPLINA_TURMA int, -- FOREIGN KEY (ID_DISCIPLINA_TURMA) REFERENCES DISCIPLINA_TURMA(ID_DISC_TURMA)
    DATA_HORA timestamp,
    PRESENCA varchar,
    PRIMARY KEY(ID_ALUNO, ID_DISCIPLINA_TURMA)
);

-- PESSOA
INSERT INTO fbd.pessoa (ID, MATRICULA, NOME_ALUNO, ATIVO, ALUNO_PROFESSOR)
	VALUES (1, '201811985', 'Francielle Vasconcellos Pereira', True, 'A');
INSERT INTO fbd.pessoa (ID, MATRICULA, NOME_ALUNO, ATIVO, ALUNO_PROFESSOR)
	VALUES (2, '201811975', 'Rene Ferrari', True, 'A');
INSERT INTO fbd.pessoa (ID, MATRICULA, NOME_ALUNO, ATIVO, ALUNO_PROFESSOR)
	VALUES (3, '201711985', 'Pedro Henrique Rossato', True, 'A');
INSERT INTO fbd.pessoa (ID, MATRICULA, NOME_ALUNO, ATIVO, ALUNO_PROFESSOR)
	VALUES (4, '201211985', 'Professor 1', True, 'P');
INSERT INTO fbd.pessoa (ID, MATRICULA, NOME_ALUNO, ATIVO, ALUNO_PROFESSOR)
	VALUES (5, '201211935', 'Professor 2', True, 'P');
select * from pessoa;

-- CURSO
INSERT INTO fbd.curso (ID_CURSO, SIGLA, NOME_CURSO)
	VALUES (1, 'CCUFSM', 'Ciencia da Comptuaçao');
INSERT INTO fbd.curso (ID_CURSO, SIGLA, NOME_CURSO)
	VALUES (2, 'SIUFSM', 'Sistemas de Informaçao');
INSERT INTO fbd.curso (ID_CURSO, SIGLA, NOME_CURSO)
	VALUES (2, 'ECUFSM', 'Engenharia de Computaçao');
select * from curso;

-- DISCIPLINA
INSERT INTO fbd.disciplina (CODIGO, NOME_DISC)
	VALUES ('ELC1018', 'Fundamentos de Banco de Dados');
INSERT INTO fbd.disciplina (CODIGO, NOME_DISC)
	VALUES ('MTM1019', 'Metodos Numericos Computacionais');
select * from disciplina;

-- TURMA
INSERT INTO fbd.turma (ID_TURMA, NOME_TURMA, PERIODO, TURNO, ID_CURSO)
	VALUES (1, 'CC', '2019/2', 'Manhã', 1);
INSERT INTO fbd.turma (ID_TURMA, NOME_TURMA, PERIODO, TURNO, ID_CURSO)
	VALUES (2, 'SI', '2019/2', 'Tarde', 2);
select * from turma;

-- DISCIPLINA_TURMA
INSERT INTO fbd.disciplina_turma (ID_DISC_TURMA, ID_DISCIPLINA, ID_PROFESSOR, ID_TURMA, CARGA_HORARIA, NR_VAGAS)
	VALUES (u1, 'MTM1019', 4, 1, 75, 30);
INSERT INTO fbd.disciplina_turma (ID_DISC_TURMA, ID_DISCIPLINA, ID_PROFESSOR, ID_TURMA, CARGA_HORARIA, NR_VAGAS)
	VALUES (2, 'ELC1018', 5, 1, 75, 20);
INSERT INTO fbd.disciplina_turma (ID_DISC_TURMA, ID_DISCIPLINA, ID_PROFESSOR, ID_TURMA, CARGA_HORARIA, NR_VAGAS)
	VALUES (3, 'MTM1019', 4, 2, 75, 30);
select * from disciplina_turma;

-- DIARIO
	--metodos
INSERT INTO fbd.diario (ID_ALUNO, ID_DISCIPLINA_TURMA, DATA_HORA, PRESENCA)
	VALUES (1, 2, '2019-12-01 10:51', 'P');
INSERT INTO fbd.diario (ID_ALUNO, ID_DISCIPLINA_TURMA, DATA_HORA, PRESENCA)
	VALUES (2, 2, '2019-12-01 10:51', 'P');
INSERT INTO fbd.diario (ID_ALUNO, ID_DISCIPLINA_TURMA, DATA_HORA, PRESENCA)
	VALUES (3, 2, '2019-12-01 10:51', 'F');
	-- fbd
INSERT INTO fbd.diario (ID_ALUNO, ID_DISCIPLINA_TURMA, DATA_HORA, PRESENCA)
	VALUES (1, 3, '2019-11-26 10:51', 'P');
INSERT INTO fbd.diario (ID_ALUNO, ID_DISCIPLINA_TURMA, DATA_HORA, PRESENCA)
	VALUES (2, 3, '2019-11-26 10:51', 'P');
select * from fbd.diario;


SELECT diario.data_hora, pessoa.nome_aluno, diario.presenca
FROM diario, pessoa
WHERE diario.id_aluno = 2
allow filtering