package main

import (
	"database/sql"
	"log"
	"os"

	"github.com/google/uuid"
	_ "github.com/lib/pq"
)

type Storage interface {
	CreateUser(*User) error
	///////////////////////////////////UpdateUser(*User) error - TODO обновление схемы пользователя, прав доступа
	GetUserByPin(int) (*User, error) //-
	CreateBoardingPass(*BPass) error //- создание проверка уже существующего
	UpdateBoardingPass(*BPass) error //- ОСНОВНАЯ ЛОГИКА
	///////////////////////////////////GetBoardingPassByBooking(string) (*BPass, error) //TODO показать текущее состояние
}

type PostgresStore struct {
	db *sql.DB
}

func NewPostgresStore() (*PostgresStore, error) {
	connStr := os.Getenv("CON_STR")
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	if err := db.Ping(); err != nil {
		return nil, err
	}
	ps := &PostgresStore{db: db}
	ps.init()
	return ps, nil
}

func (s *PostgresStore) CreateUser(*User) error {
	return nil
}

func (s *PostgresStore) GetUserByPin(pin int) (*User, error) {
	return &User{}, nil
}

func (s *PostgresStore) CreateBoardingPass(*BPass) error {
	return nil
}

func (s *PostgresStore) UpdateBoardingPass(uuid uuid.UUID, stage int) error {
	return nil
}

// / init
func (s *PostgresStore) init() error {
	s.createUserTable()
	return nil
}

func (s *PostgresStore) createUserTable() {
	quuid := `CREATE EXTENSION IF NOT EXISTS "uuid-ossp";`
	s.db.Query(quuid)
	q := `create table if not exists srv_user (
		ID uuid DEFAULT uuid_generate_v4 (),
		Name VARCHAR(178) NOT NULL,
		Number integer NOT NULL,
		Ushcema varchar(2))`
	_, err := s.db.Query(q)
	if err != nil {
		log.Fatalln(err)
	}
	q = `create table if not exists boardin_pass (
		ID uuid DEFAULT uuid_generate_v4 (),
		Name VARCHAR(178) NOT NULL,
		Booking VARCHAR(12) NOT NULL,
		FlightNumber VARCHAR(4),
		TypePass VARCHAR(1),
		
	)`
}
