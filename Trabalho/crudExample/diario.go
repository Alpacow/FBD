package main

import (
	"fmt"
	"net/http"      // Gerencia URLs e Servidor Web
)

// Função usada para renderizar o arquivo Index
func Index(w http.ResponseWriter, r *http.Request) {
	matricula := r.URL.Query().Get("matricula")
	var context Context
	context.Disciplinas = getDisciplinas(matricula)
	if r.Method == "POST" {
		context.Alunos = getAlunosByDisciplina("MTM1021")
		context.CodigoSelect = "MTM1021"
	}
	// Abre a página Index e exibe todos os registrados na tela
	tmpl.ExecuteTemplate(w, "Index", context)
}

// Função Insert, insere valores no banco de dados
func InsertDiario(w http.ResponseWriter, r *http.Request) {
	// Verifica o METHOD do formulário passado
	if r.Method == "POST" {
		// Pega os campos do formulário
		var d Diario
		var err error
		d.DataHora = r.FormValue("datahora")
		if err != nil {
			fmt.Println("Erro ao capturar dataHora");
		}
		d.CodigoDisc = r.FormValue("CodigoDisc")
		var alunos []Diario = getAlunosByDisciplina("MTM1021")
		for i, nome := range alunos {
    		fmt.Println(i, nome)
		}
		d.NomePessoa = r.FormValue("nomeTurma")
		d.Presenca = r.FormValue("periodo")
		//createDiario(d)
	}
	//Retorna a HOME
	http.Redirect(w, r, "/", 301)
}

func main() {
	// Gerencia as URLs
	http.HandleFunc("/", Index)
	http.HandleFunc("/turma", IndexTurma)
	http.HandleFunc("/show", ShowTurma)
	http.HandleFunc("/new", NewTurma)
	http.HandleFunc("/edit", EditTurma)

	// Ações
	http.HandleFunc("/insertTurma", InsertTurma)
	http.HandleFunc("/updateTurma", UpdateTurma)
	http.HandleFunc("/deleteTurma", DeleteTurma)

	// Inicia o servidor na porta 9000
	http.ListenAndServe(":9000", nil)
}

