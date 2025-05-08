import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Jibesh123!',
    database='league'
)

cursor = conn.cursor()
def show_menu():
    print("\n--- Football DB Menu ---")
    print("1. Add new player")
    print("2. View all players")
    print("3. Update player weight")
    print("4. Delete a player")
    print("5. Run queries")
    print("6. Exit")

def add_player():
    try:
        pid = int(input("Enter Player ID: "))
        name = input("Name: ")
        dob = input("DOB (YYYY-MM-DD): ")
        height = int(input("Height (cm): "))
        weight = int(input("Weight (kg): "))
        nationality = input("Nationality: ")
        team_id = int(input("Team ID: "))

        query = """
        INSERT INTO Player (Player_ID, Name, DOB, Height, Weight, Nationality, Team_ID)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (pid, name, dob, height, weight, nationality, team_id))
        conn.commit()
        print("✅ Player added successfully.")
    except Exception as e:
        print(" Error adding player:", e)

def view_players():
    try:
        cursor.execute("SELECT Player_ID, Name, Nationality FROM Player")
        rows = cursor.fetchall()
        print("\n--- Players ---")
        for row in rows:
            print(row)
    except Exception as e:
        print(" Error fetching players:", e)

def update_weight():
    try:
        pid = int(input("Player ID: "))
        new_weight = int(input("New weight: "))
        cursor.execute("UPDATE Player SET Weight = %s WHERE Player_ID = %s", (new_weight, pid))
        conn.commit()
        print("✅ Weight updated.")
    except Exception as e:
        print(" Error updating weight:", e)

def delete_player():
    try:
        pid = int(input("Enter Player ID to delete: "))
        cursor.execute("DELETE FROM Player WHERE Player_ID = %s", (pid,))
        conn.commit()
        print("✅ Player deleted.")
    except Exception as e:
        print(" Error deleting player:", e)

def run_queries():
    print("\n--- Running Sample Queries ---")
    queries = [
        ("Players from Brazil", 
         "SELECT Name FROM Player WHERE Nationality = 'Brazil'"),
        
        ("Top 5 scorers", 
         "SELECT P.Name, S.Goals_Scored FROM Player P JOIN Statistics S ON P.Player_ID = S.Player_ID ORDER BY Goals_Scored DESC LIMIT 5"),
        
        ("Players and their teams", 
         "SELECT P.Name, T.Name FROM Player P JOIN Team T ON P.Team_ID = T.Team_ID"),
        
        ("Average pass accuracy", 
         "SELECT AVG(Pass_Accuracy) FROM Statistics")
    ]

    for desc, q in queries:
        print(f"\n{desc}:")
        try:
            cursor.execute(q)
            for row in cursor.fetchall():
                print(row)
        except Exception as e:
            print(" Query failed:", e)
while True:
    show_menu()
    choice = input("Enter choice: ")
    if choice == '1':
        add_player()
    elif choice == '2':
        view_players()
    elif choice == '3':
        update_weight()
    elif choice == '4':
        delete_player()
    elif choice == '5':
        run_queries()
    elif choice == '6':
        print("Goodbye!")
        break
    else:
        print(" Invalid choice. Please select 1–6.")
cursor.close()
conn.close()