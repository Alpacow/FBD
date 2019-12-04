package main

import (
	"fmt"
	"github.com/gocql/gocql"
)

var Session* gocql.Session

type Turma struct {
	IdTurma   int
	NomeTurma string
	Periodo   string
	Turno     string
}

// INICIA CONEXÃO COM BANCO
func init() {
	var err error

	cluster := gocql.NewCluster("127.0.0.1")
	cluster.Keyspace = "fbd"
	Session, err = cluster.CreateSession()
	if err != nil {
		panic(err)
	}
	fmt.Println("Conexão com Cassandra realizada.")
}

func createTurma(t Turma) {
	fmt.Println(" **** Criando nova Turma ****\n", t)
	if err := Session.Query("INSERT INTO fbd.turma (id_turma, nome_turma, periodo, turno) VALUES (?, ?, ?, ?);",
		t.IdTurma, t.NomeTurma, t.Periodo, t.Turno).Exec(); err != nil {
		fmt.Println("Erro ao inserir turma")
		fmt.Println(err)
	}
}

func getTurma(id string) Turma {
	fmt.Println("Selecionando uma turma")
	var turma Turma
	m := map[string]interface{}{}
 
	iter := Session.Query("SELECT * FROM turma WHERE id_turma = ?", id).Iter()
	for iter.MapScan(m) {
		turma = Turma{
			IdTurma:   m["id_turma"].(int),
			NomeTurma: m["nome_turma"].(string),
			Periodo:   m["periodo"].(string),
			Turno:     m["turno"].(string),
		}
		m = map[string]interface{}{}
	}
	return turma
}

func getTurmas() []Turma {
	fmt.Println("Selecionando todas as turmas")
	var turmas []Turma
	m := map[string]interface{}{}
 
	iter := Session.Query("SELECT * FROM turma").Iter()
	for iter.MapScan(m) {
		turmas = append(turmas, Turma{
			IdTurma:   m["id_turma"].(int),
			NomeTurma: m["nome_turma"].(string),
			Periodo:   m["periodo"].(string),
			Turno:     m["turno"].(string),
		})
		m = map[string]interface{}{}
	}
	return turmas
}
	
func updateTurma(t Turma) {
	fmt.Printf("Atualizando turma com id = %s\n", t.IdTurma)
	if err := Session.Query("UPDATE turma SET nome_turma = ?, periodo = ?, turno = ? WHERE id_turma = ?",
		t.NomeTurma, t.Periodo, t.Turno, t.IdTurma).Exec(); err != nil {
		fmt.Println("Erro ao atualizar Turma")
		fmt.Println(err)
	}
}

func deleteTurma(id int) {
	fmt.Printf("Deletando turma com id = %s\n", id)
	if err := Session.Query("DELETE FROM turma WHERE id_turma = ?", id).Exec(); err != nil {
		fmt.Println("Erro ao deletar Turma")
		fmt.Println(err)
	}
}

/*
func main() {
	//turma1 := Turma{1, "CC1", "2019/1", "Manhã"}
	//turma2 := Turma{2, "CC2", "2019/2", "Tarde"}
	//createTurma(turma1)
	fmt.Println(getTurmas())
	fmt.Println(getTurma(4))
	//createTurma(turma2)
	//fmt.Println(getTurmas())
	/*Turma3 := Turma{3, "SI", "2019/2", "Tarde"}
	updateTurma(Turma3)
	fmt.Println(getTurmas())
	deleteTurma(2)
	fmt.Println(getTurmas())
}
*/
