package main

type Storage interface {
	CreateUser(*User) error
	UpdateUser(*User) error
	GetUserByPin(int) (*User, error)
	CreateBoardingPass(*BPass) error
	UpdateBoardingPass(*BPass) error
	GetBoardingPassByBooking(string) (*BPass, error)
}
