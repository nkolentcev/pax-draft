package main

import "database/sql"

type Storage interface {
	CreateUser(*User) error
	//UpdateUser(*User) error - TODO обновление схемы пользователя, прав доступа
	GetUserByPin(int) (*User, error)
	CreateBoardingPass(*BPass) error //создание проверка уже существующего
	UpdateBoardingPass(*BPass) error //ОСНОВНАЯ ЛОГИКА
	//GetBoardingPassByBooking(string) (*BPass, error) //TODO показать текущее состояние
}

type PostgresStore struct {
	db *sql.DB
}

func NewPostgresStore() (*PostgresStore, error) {
	connStr := "postgres://pqgotest:password@localhost/pqgotest?sslmode=verify-full"

}
