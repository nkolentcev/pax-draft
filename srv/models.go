package main

import "github.com/google/uuid"

type CreateUserRequest struct {
	Name    string `json:"name"`
	Number  string `json:"number"`
	Ushcema string `json:"uschema"`
}

type CreateBoardPassRequest struct {
	Name         string `json:"name"`
	Booking      string `json:"booking"`
	FlightNumber string `json:"flight_number"`
	TypePass     string `json:"type_pass"`
	Zone         string `json:"zone"`
	Sit          string `json:"sit"`
}

type User struct {
	ID      uuid.UUID `json:"id"`
	Name    string    `json:"name"`
	Number  int       `json:"number"`
	Ushcema string    `json:"uschema"`
}

type BPass struct {
	ID           uuid.UUID `json:"id"`
	Name         string    `json:"name"`
	Booking      string    `json:"booking"`
	FlightNumber string    `json:"flight_number"`
	TypePass     string    `json:"type_pass"`
	Zone         string    `json:"zone"`
	Sit          string    `json:"sit"`
	Check1       bool      `json:"check1"`
	Check2       bool      `json:"check2"`
	Check3       bool      `json:"check3"`
	ICheck1      int       `json:"icheck1"`
	ICheck2      int       `json:"icheck2"`
	ICheck3      int       `json:"icheck3"`
}

func NewUser(Name string, Number int, Ushema string) *User {
	return &User{
		ID:      uuid.New(),
		Name:    Name,
		Number:  Number,
		Ushcema: Ushema,
	}
}

func NewBPass(Name, Booking, FlightNumber, TypePass, Zone, Sit string) *BPass {
	return &BPass{
		ID:           uuid.New(),
		Name:         Name,
		Booking:      Booking,
		FlightNumber: FlightNumber,
		TypePass:     TypePass,
		Zone:         Zone,
		Sit:          Sit,
		Check1:       false,
		Check2:       false,
		Check3:       false,
		ICheck1:      0,
		ICheck2:      0,
		ICheck3:      0,
	}
}
