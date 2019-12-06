package main

import (
	"fmt"
)

type Diario struct {
	NomePessoa string
	CodigoDisc string
	DataHora   string
	Presenca   string
}

type Disciplina struct {
	CodigoDisc string
}

type Context struct {
	Alunos []Diario
	Disciplinas []Disciplina
	CodigoSelect string
}

func createDiario(d Diario) {
	fmt.Println(" **** Criando novo Diario de classe ****\n", d)
	if err := Session.Query("INSERT INTO fbd.diario (nome_pessoa, codigo_disc, data_hora, presenca) VALUES (?, ?, ?, ?);",
		d.NomePessoa, d.CodigoDisc, d.DataHora, d.Presenca).Exec(); err != nil {
		fmt.Println("Erro ao inserir diario")
		fmt.Println(err)
	}
}

func getDisciplinas(matricula string) []Disciplina {
	fmt.Println("Selecionando disciplinas")
	var d []Disciplina
	m := map[string]interface{}{}
 
	iter := Session.Query("SELECT * FROM disciplina_pessoa WHERE matricula = ?", matricula).Iter()
	for iter.MapScan(m) {
		d = append(d, Disciplina{
			CodigoDisc:   m["codigo_disc"].(string),
		})
		m = map[string]interface{}{}
	}
	return d
}

func getAlunosByDisciplina(codigo string) []Diario {
	fmt.Println("Selecionando alunos")
	var d []Diario
	m := map[string]interface{}{}
 
	iter := Session.Query("SELECT nome_pessoa FROM disciplina_pessoa WHERE codigo_disc = ? allow filtering", codigo).Iter()
	for iter.MapScan(m) {
		d = append(d, Diario{
			NomePessoa: m["nome_pessoa"].(string),
		})
		m = map[string]interface{}{}
	}
	return d
}

/*
func getDiarioByData(id string) Turma {
	fmt.Println("Selecionando diarios")
	var diario Diario
	m := map[string]interface{}{}
 
	iter := Session.Query("SELECT * FROM diario WHERE data_hora = ? and nome_pessoa = ?", dthora, nome).Iter()
	for iter.MapScan(m) {
		diario = Diario{
			NomePessoa:   m["nome_pessoa"].(int),
			CodigoDisc: m["codigo_disc"].(string),
			DataHora:   m["data_hora"].(string),
			Presenca:     m["presenca"].(string),
		}
		m = map[string]interface{}{}
	}
	return diario
}

func getDiarioByDisciplina() []Diario {
	fmt.Println("Selecionando todas presencas de uma disciplina")
	var diarios []Diario
	m := map[string]interface{}{}
 
	iter := Session.Query("SELECT * FROM diario").Iter()
	for iter.MapScan(m) {
		diarios = append(diarios, Diario{
			IdTurma:   m["id_turma"].(int),
			NomeTurma: m["nome_turma"].(string),
			Periodo:   m["periodo"].(string),
			Turno:     m["turno"].(string),
		})
		m = map[string]interface{}{}
	}
	return turmas
}

func updateDiario(d Diario) {
	fmt.Printf("Atualizando Diario")
	if err := Session.Query("UPDATE diario SET presenca = ? WHERE data_hora = ? and codigo_disc = ? and nome_pessoa = ?",
		d.Presenca, d.DataHora, d.CodigoDisc, d.NomePessoa).Exec(); err != nil {
		fmt.Println("Erro ao atualizar Diario")
		fmt.Println(err)
	}
}

func deleteDiario(id int) {
	fmt.Printf("Deletando turma com id = %s\n", id)
	if err := Session.Query("DELETE FROM turma WHERE id_turma = ?", id).Exec(); err != nil {
		fmt.Println("Erro ao deletar Turma")
		fmt.Println(err)
	}
}
*/
