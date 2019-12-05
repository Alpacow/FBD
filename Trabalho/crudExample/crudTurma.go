package main

import (
	"fmt"
	"net/http"      // Gerencia URLs e Servidor Web
	"text/template" // Gerencia templates
	"strconv"
)

var tmpl = template.Must(template.ParseGlob("templates/*"))

// Função usada para renderizar o arquivo Index
func Index(w http.ResponseWriter, r *http.Request) {
	var turmas = getTurmas()
	// Abre a página Index e exibe todos os registrados na tela
	fmt.Println(tmpl)
	tmpl.ExecuteTemplate(w, "TurmaIndex", turmas)
}

// Função Show exibe apenas um resultado
func Show(w http.ResponseWriter, r *http.Request) {
	id := r.URL.Query().Get("id")
	var turma Turma = getTurmaById(id)
	// Abre a página Index e exibe todos os registrados na tela
	tmpl.ExecuteTemplate(w, "TurmaShow", turma)
}

// Função New apenas exibe o formulário para inserir novos dados
func New(w http.ResponseWriter, r *http.Request) {
	tmpl.ExecuteTemplate(w, "TurmaNew", nil)
}

// Função Edit, edita os dados
func Edit(w http.ResponseWriter, r *http.Request) {
	// Pega o ID do parametro da URL
	id := r.URL.Query().Get("id")
	var turma Turma = getTurmaById(id)
	// Mostra o template com formulário preenchido para edição
	tmpl.ExecuteTemplate(w, "TurmaEdit", turma)
}

// Função Insert, insere valores no banco de dados
func Insert(w http.ResponseWriter, r *http.Request) {
	// Verifica o METHOD do formulário passado
	fmt.Println(r.Method)
	if r.Method == "POST" {
		// Pega os campos do formulário
		var t Turma
		var err error
		t.IdTurma, err = strconv.Atoi(r.FormValue("id"))
		if err != nil {
			fmt.Println("Erro ao capturar Id");
		}
		t.NomeTurma = r.FormValue("nomeTurma")
		t.Periodo = r.FormValue("periodo")
		t.Turno = r.FormValue("turno")
		createTurma(t)
	}
	//Retorna a HOME
	http.Redirect(w, r, "/", 301)
}

// Função Update, atualiza valores no banco de dados
func Update(w http.ResponseWriter, r *http.Request) {
	// Verifica o METHOD do formulário passado
	fmt.Println(r.Method)
	if r.Method == "POST" {
		// Pega os campos do formulário
		var t Turma
		var err error
		t.IdTurma, err = strconv.Atoi(r.FormValue("id"))
		if err != nil {
			fmt.Println("Erro ao capturar Id");
		}
		t.NomeTurma = r.FormValue("nomeTurma")
		t.Periodo = r.FormValue("periodo")
		t.Turno = r.FormValue("turno")
		fmt.Println(t.IdTurma, t.NomeTurma)
		updateTurma(t)
	}
	// Retorna a HOME
	http.Redirect(w, r, "/", 301)
}

// Função Delete, deleta valores no banco de dados
func Delete(w http.ResponseWriter, r *http.Request) {
	var err error
	id, err := strconv.Atoi(r.FormValue("id"))
	if err != nil {
		fmt.Println("Erro ao capturar Id");
	}
	deleteTurma(id)
	// Retorna a HOME
	http.Redirect(w, r, "/", 301)
}

func main() {
	// Gerencia as URLs

	http.HandleFunc("/", Index)
	http.HandleFunc("/show", Show)
	http.HandleFunc("/new", New)
	http.HandleFunc("/edit", Edit)

	// Ações
	http.HandleFunc("/insert", Insert)
	http.HandleFunc("/update", Update)
	http.HandleFunc("/delete", Delete)

	// Inicia o servidor na porta 9000
	http.ListenAndServe(":9000", nil)
	
}

