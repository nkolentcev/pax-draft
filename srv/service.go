package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

type APIService struct {
	listenAddr string
}

func NewAPIService(listenAddr string) *APIService {
	return &APIService{
		listenAddr: listenAddr,
	}
}

type apiFunc func(http.ResponseWriter, *http.Request) error

type ApiError struct {
	Error string
}

func makeHTTPHandlerFunc(f apiFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if err := f(w, r); err != nil {
			WriteJSON(w, http.StatusBadRequest, ApiError{Error: err.Error()})
		}
	}
}

func WriteJSON(w http.ResponseWriter, status int, v any) error {
	w.WriteHeader(status)
	w.Header().Add("Content-Type", "application/json")
	return json.NewEncoder(w).Encode(v)
}

func (s *APIService) handleUser(w http.ResponseWriter, r *http.Request) error {
	if r.Method == "GET" {
		return s.handleGetUser(w, r)
	}
	if r.Method == "PUT" {
		return s.handleCreateUser(w, r)
	}
	if r.Method == "PATCH" {
		return s.handleUpdateUser(w, r)
	}
	return fmt.Errorf("method undefined")
}

func (s *APIService) handleBoardingPass(w http.ResponseWriter, r *http.Request) error {
	if r.Method == "GET" {
		return s.handleCheckBoardingPass(w, r)
	}
	if r.Method == "PUT" {
		return s.handleCreateBoardingPass(w, r)
	}
	if r.Method == "PATCH" {
		return s.handleUpdateBoardingPass(w, r)
	}
	return fmt.Errorf("method undefined")
}

// ПОЛЬЗОВАТЕЛИ
func (s *APIService) handleGetUser(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (s *APIService) handleCreateUser(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (s *APIService) handleUpdateUser(w http.ResponseWriter, r *http.Request) error {
	return nil
}

// ПОСАДОЧНЫЕ
func (s *APIService) handleCheckBoardingPass(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (s *APIService) handleCreateBoardingPass(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (s *APIService) handleUpdateBoardingPass(w http.ResponseWriter, r *http.Request) error {
	return nil
}

// / RUNNER
func (s *APIService) Run() {
	router := mux.NewRouter()
	router.HandleFunc("/user", makeHTTPHandlerFunc(s.handleUser))
	router.HandleFunc("/bpas", makeHTTPHandlerFunc(s.handleBoardingPass))
	log.Print("api server runinig on port: ", s.listenAddr)
	http.ListenAndServe(s.listenAddr, router)

}
