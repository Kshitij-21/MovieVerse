
import sqlite3

DB_FILE = "movieverse.db"

def connect():
    return sqlite3.connect(DB_FILE)

def init_db():
    with open("MovieVerse_SQL_Project.sql", "r") as f:
        sql_script = f.read()
    with connect() as conn:
        conn.executescript(sql_script)
        print("✅ Database created from SQL script.")

def top_rated_movies():
    query = '''
    SELECT M.title, ROUND(AVG(R.rating), 2) AS avg_rating
    FROM Movies M
    JOIN Reviews R ON M.movie_id = R.movie_id
    GROUP BY M.movie_id
    ORDER BY avg_rating DESC
    LIMIT 3;
    '''
    with connect() as conn:
        for row in conn.execute(query):
            print(f"🎥 {row[0]} — ⭐ {row[1]}")

def most_active_users():
    query = '''
    SELECT U.name, SUM(W.watch_duration) AS total_minutes
    FROM Users U
    JOIN Watch_History W ON U.user_id = W.user_id
    GROUP BY U.user_id
    ORDER BY total_minutes DESC;
    '''
    with connect() as conn:
        for row in conn.execute(query):
            print(f"👤 {row[0]} — ⏱️ {row[1]} mins")

def recommend_scifi(user_id):
    query = f'''
    SELECT DISTINCT M.title
    FROM Movies M
    JOIN Movie_Genres MG ON M.movie_id = MG.movie_id
    JOIN Genres G ON MG.genre_id = G.genre_id
    WHERE G.name = 'Sci-Fi'
    AND M.movie_id NOT IN (
        SELECT movie_id FROM Watch_History WHERE user_id = {user_id}
    );
    '''
    with connect() as conn:
        results = conn.execute(query).fetchall()
        if not results:
            print("🎉 No new Sci-Fi movies to recommend!")
        for row in results:
            print(f"📽️ {row[0]}")

def search_masterpiece_reviews():
    query = '''
    SELECT DISTINCT M.title
    FROM Reviews R
    JOIN Movies M ON R.movie_id = M.movie_id
    WHERE LOWER(R.comment) LIKE '%masterpiece%';
    '''
    with connect() as conn:
        for row in conn.execute(query):
            print(f"📝 Mentioned as Masterpiece: {row[0]}")

def menu():
    print("🎬 MovieVerse CLI")
    print("1. Top 3 Rated Movies")
    print("2. Most Active Users")
    print("3. Recommend Sci-Fi Movies (User ID 1)")
    print("4. Find 'Masterpiece' Mentions in Reviews")
    print("0. Exit")

    while True:
        choice = input("Choose an option: ")
        if choice == "1":
            top_rated_movies()
        elif choice == "2":
            most_active_users()
        elif choice == "3":
            recommend_scifi(1)
        elif choice == "4":
            search_masterpiece_reviews()
        elif choice == "0":
            break
        else:
            print("Invalid option. Try again.")

if __name__ == "__main__":
    # init_db()  # Only run once
    menu()
