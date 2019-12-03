-- to run: ./bin/cqlsh
USE fbd;

CREATE TABLE PESSOA (
	ID int primary key not null auto_increment,
	MATRICULA varchar(10) not null,
	NOME_ALUNO varchar(200) not null,
	ATIVO bool not null,
    ALUNO_PROFESSOR char not null
);

CREATE TABLE CURSO (
	ID_CURSO int primary key not null auto_increment,
	SIGLA varchar(10) not null,
	NOME_CURSO varchar(250) not null
);

CREATE TABLE TURMA (
	ID_TURMA int primary key not null,
    NOME_TURMA varchar(250) not null,
    PERIODO char(6),
    TURNO varchar(10),
    ID_CURSO int not null,
    CONSTRAINT FK_IdCurso FOREIGN KEY (ID_CURSO)
		REFERENCES CURSO(ID_CURSO)
);

CREATE TABLE DISCIPLINA (
	CODIGO char(7) primary key not null, -- elc1069
    NOME_DISC varchar(200) not null
);

-- Manter ou não??
CREATE TABLE ALUNO_TURMA(
	ID_ALUNO int not null,
    ID_TURMA int not null,
    CONSTRAINT FK_IdAluno FOREIGN KEY (ID_ALUNO)
		REFERENCES PESSOA(ID),
	CONSTRAINT FK_IdTurma FOREIGN KEY (ID_TURMA)
		REFERENCES TURMA(ID_TURMA)
);

/*
CREATE TABLE HORA_DISC_TURMA(
	ID_HORARIO int primary key not null,
	DIA varchar(10) not null,
    HORA time not null,
    ID_DISC_TURMA int not null,
    CONSTRAINT FK_IdDiscTurma FOREIGN KEY (ID_DISC_TURMA)
		REFERENCES DISCIPLINA_TURMA(ID_DISC_TURMA)
);
*/

CREATE TABLE DISCIPLINA_TURMA(
	ID_DISC_TURMA int primary key not null,
    ID_DISCIPLINA char(7) not null,
    ID_PROFESSOR int not null,
    ID_TURMA int,
    CARGA_HORARIA int,
    NR_VAGAS int not null,
    CONSTRAINT FK_IdDisciplina FOREIGN KEY (ID_DISCIPLINA)
		REFERENCES DISCIPLINA(CODIGO),
	CONSTRAINT FK_IdDisciplinaTurma FOREIGN KEY (ID_TURMA)
		REFERENCES TURMA(ID_TURMA),
	CONSTRAINT FK_IdProfessor FOREIGN KEY (ID_PROFESSOR)
		REFERENCES PESSOA(ID)
);

CREATE TABLE DIARIO(
	ID_ALUNO int not null,
    ID_DISCIPLINA_TURMA int not null,
    DATA_HORA datetime not null,
    PRESENCA char(1) not null,
    CONSTRAINT FK_IdDiarioAluno FOREIGN KEY (ID_ALUNO)
		REFERENCES ALUNO_TURMA(ID_ALUNO),
	CONSTRAINT FK_IdDiscTurma FOREIGN KEY (ID_DISCIPLINA_TURMA)
		REFERENCES DISCIPLINA_TURMA(ID_DISC_TURMA)
);

