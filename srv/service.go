package main

import "net/http"

type APIService struct {
	listenAddr string
}

func NewAPIService(listenAddr string) *APIService {
	return &APIService{
		listenAddr: listenAddr,
	}
}

func (s *APIService) handleUser(w http.ResponseWriter, r *http.Request) error {
	return nil
}

func (s *APIService) handleBoardingPass(w http.ResponseWriter, r *http.Request) error {
	return nil
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
