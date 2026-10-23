package guests

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
)

type Guest struct {
	ID             int     `json:"id"`
	FullName       string  `json:"full_name"`
	Phone          string  `json:"phone"`
	Identification string  `json:"identification"`
	Address        *string `json:"address"`
	Mail           *string `json:"mail"`
}

func Create(pool *pgxpool.Pool, g Guest) (int, error) {
	var guestID int
	err := pool.QueryRow(context.Background(), "INSERT INTO guests(full_name, phone, identification, address, mail) VALUES ($1, $2, $3, $4, $5) RETURNING id", g.FullName, g.Phone, g.Identification, g.Address, g.Mail).Scan(&guestID)
	if err != nil {
		return 0, err
	}
	return guestID, nil
}

func GetAll(pool *pgxpool.Pool) ([]Guest, error) {
	rows, err := pool.Query(context.Background(), "SELECT id, full_name, phone, identification, address, mail FROM guests ORDER BY full_name")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	guests := []Guest{}

	for rows.Next() {
		var g Guest
		err := rows.Scan(&g.ID, &g.FullName, &g.Phone, &g.Identification, &g.Address, &g.Mail)
		if err != nil {
			return nil, err
		}
		guests = append(guests, g)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return guests, nil
}
