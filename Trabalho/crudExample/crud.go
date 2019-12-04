package main

import (
	"net/http"      // Gerencia URLs e Servidor Web
	"text/template" // Gerencia templates
)

var tmpl = template.Must(template.ParseGlob("templates/*"))

// Função usada para renderizar o arquivo Index
func Index(w http.ResponseWriter, r *http.Request) {
	var turmas = getTurmas()
	// Abre a página Index e exibe todos os registrados na tela
	tmpl.ExecuteTemplate(w, "Index", turmas)
}

// Função Show exibe apenas um resultado
func Show(w http.ResponseWriter, r *http.Request) {
	id := r.URL.Query().Get("id")
	var turma Turma = getTurma(id)
	// Abre a página Index e exibe todos os registrados na tela
	tmpl.ExecuteTemplate(w, "Show", turma)
}

// Função New apenas exibe o formulário para inserir novos dados
func New(w http.ResponseWriter, r *http.Request) {
	tmpl.ExecuteTemplate(w, "New", nil)
}

// Função Edit, edita os dados
func Edit(w http.ResponseWriter, r *http.Request) {
	// Pega o ID do parametro da URL
	id := r.URL.Query().Get("id")
	var turma Turma = getTurma(id)
	// Mostra o template com formulário preenchido para edição
	tmpl.ExecuteTemplate(w, "Edit", turma)
}


func main() {
	// Gerencia as URLs

	http.HandleFunc("/", Index)
	http.HandleFunc("/show", Show)
	http.HandleFunc("/new", New)
	http.HandleFunc("/edit", Edit)

	// Ações
	/*
	http.HandleFunc("/insert", Insert)
	http.HandleFunc("/update", Update)
	http.HandleFunc("/delete", Delete)
	*/

	// Inicia o servidor na porta 9000
	http.ListenAndServe(":9000", nil)
	
}

