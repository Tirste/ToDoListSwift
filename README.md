# ToDoListSwift

## Opis: 
Projekt aplikacji przygotowany na zajęcia Zaawansowane programowanie SWIFT.
Prosta aplikacja ToDoList umożliwiająca utworzenie kategorii, wewnątrz których można dodawać zadania np. lista zakupow. Kategorie oraz zadania mozna edytowac.

Autor: Jarosław Królikowski (I2N grupa 2.2)

## Wymagania

### Projekt powinien posiadać:

1. Minimum trzy widoki, po których możliwa jest nawigacja;

       Projekt posiada 6 widoków
   
2. Pobierać dane od użytkownika i sprawdzać ich poprawność;

        Dane pobierane są w tytule, akceptowane są tylko litery - cyfry, znaki specjalne nie

3) Obsługiwać minimum trzy gesty, gesty już zaimplementowane nie są liczone (np. akcja przycisku);

        Zaimplementowano gest tapnięcia (oznaczenie, że zadanie jest gotowe), przytrzymania (menu kontekstowe), przesunięcia w lewo i prawo (edycja lub kasowanie)

4) Zawierać pięć różnych kontrolek;

        Niestety nie ma 5 różnych kontrolek

5) Zawierać wyświetlenie grafiki;

        Grafika jest wyświetlana w głównym widoku
   
6) Korzystać z Core Data (min. 2 powiązane encje).

       Utworzono 2 encje które są powiązane - many to one

## Encje:
### Task

#### Atrybuty
![image](https://github.com/Tirste/ToDoListSwift/assets/21289776/ecbd8a9c-7da3-42f6-96b9-1c081e45dc43)

#### Relacja
![image](https://github.com/Tirste/ToDoListSwift/assets/21289776/d662da0d-318b-464b-9f53-f9dfc2ef7301)

### Category

#### Atrybuty

![image](https://github.com/Tirste/ToDoListSwift/assets/21289776/0ca05a3f-ed89-4123-97c5-2a17d49e0a1b)

#### Relacja

![image](https://github.com/Tirste/ToDoListSwift/assets/21289776/e5defa65-fe71-4921-ba14-2f407472b25d)


## Widoki:
1. MainView.swift - główny widok, zawiera tytuł, grafike, liste kategorii, przycisk dodania nowej kategorii
2. AddCategoryView.swift - widok dodawania nowej kategorii, w ktorej znajduja się zadania (taski)
3. EditCategoryView.swift - widok typu sheet do edycji nazwy kategorii
4. AddTaskView.swift - widok dodawania nowego zadania, mozliwosc dodania tytulu i daty
5. EditTaskView.swift - widok edycji zadania - edcyja tytulu i daty
6. TaskListView.swift - widok wszystkich zadan dla wybranej kategorii


## Aplikacja w menu (ikona aplikacji):
![image](https://github.com/Tirste/ToDoListSwift/assets/21289776/56cb1998-588b-4458-80a2-81e7afaadbc1)

## Prezentacja dzialania
![ezgif-5-59cee014fc](https://github.com/Tirste/ToDoListSwift/assets/21289776/bd706801-a765-475c-a554-1969ee046be0)
![ezgif-5-ca30f7f140](https://github.com/Tirste/ToDoListSwift/assets/21289776/3b1ebfc5-f989-4444-a581-2f0c02c6e947)
