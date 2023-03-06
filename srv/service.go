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
	db         *PostgresStore
}

func NewAPIService(listenAddr string, db *PostgresStore) *APIService {
	return &APIService{
		listenAddr: listenAddr,
		db:         db,
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
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(status)
	return json.NewEncoder(w).Encode(v)
}

func (s *APIService) handleUser(w http.ResponseWriter, r *http.Request) error {
	// if r.Method == "GET" {
	// 	return s.handleGetUser(w, r)
	// }
	if r.Method == "POST" {
		return s.handleCreateUser(w, r)
	}
	if r.Method == "PATCH" {
		return s.handleUpdateUser(w, r)
	}
	return fmt.Errorf("method undefined")
}

func (s *APIService) handleBoardingPass(w http.ResponseWriter, r *http.Request) error {
	// if r.Method == "GET" {
	// 	return s.handleCheckBoardingPass(w, r)
	// }
	if r.Method == "POST" {
		return s.handleCreateBoardingPass(w, r)
	}
	if r.Method == "PATCH" {
		return s.handleUpdateBoardingPass(w, r)
	}
	return fmt.Errorf("method undefined")
}

// ПОЛЬЗОВАТЕЛИ
func (s *APIService) handleGetUser(w http.ResponseWriter, r *http.Request) error {
	pin := mux.Vars(r)["pin"]
	fmt.Println(pin)
	return WriteJSON(w, http.StatusOK, &User{})
}

func (s *APIService) handleCreateUser(w http.ResponseWriter, r *http.Request) error {
	newuser := new(CreateUserRequest)
	err := json.NewDecoder(r.Body).Decode(newuser)
	fmt.Println(&newuser)
	if err != nil {
		return WriteJSON(w, http.StatusBadRequest, ApiError{Error: err.Error()})
	}

	return WriteJSON(w, http.StatusOK, newuser)
}

func (s *APIService) handleUpdateUser(w http.ResponseWriter, r *http.Request) error {
	return nil
}

// ПОСАДОЧНЫЕ
func (s *APIService) handleCheckBoardingPass(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (s *APIService) handleCreateBoardingPass(w http.ResponseWriter, r *http.Request) error {
	newbp := new(CreateBoardPassRequest)
	err := json.NewDecoder(r.Body).Decode(newbp)
	fmt.Println(&newbp)
	if err != nil {
		return WriteJSON(w, http.StatusBadRequest, ApiError{Error: err.Error()})
	}

	return WriteJSON(w, http.StatusOK, newbp)
}

func (s *APIService) handleUpdateBoardingPass(w http.ResponseWriter, r *http.Request) error {
	return nil
}

// / RUNNER
func (s *APIService) Run() {
	router := mux.NewRouter()
	router.HandleFunc("/user", makeHTTPHandlerFunc(s.handleUser))
	router.HandleFunc("/bpas", makeHTTPHandlerFunc(s.handleBoardingPass))

	router.HandleFunc("/user/{pin}", makeHTTPHandlerFunc(s.handleGetUser))
	router.HandleFunc("/bpas/{booking}", makeHTTPHandlerFunc(s.handleCheckBoardingPass))

	log.Print("api server runinig on port: ", s.listenAddr)
	http.ListenAndServe(s.listenAddr, router)

}
