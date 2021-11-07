# Zjazd 4 

## Wstęp
Dostaleś w ramach zadania 4 trochę kodu, który pokazuje jak:
1) Tworzyć role 
2) Tworzyć polityki
3) Tworzyć SPN / Managed Identity

Po pierwsze, przejzyj ten kod - warto rozumieć co moze dla Ciebie zrobic!

## Zmiany w kodzie
Zanim pójdziesz dalej - zmień kod tak, by zawierał ładnie dodany prefix do Twoich ról i polityk. 
Nie chcesz nadpisać polityk innej osobie i chcesz widzieć tylko swoje zasoby a więc to się na pewno przyda.

## Kod nie jest kompletny 
Kod, który przekazałem nie jest komplety. Aby go rozstawić przyda się zapewne:
1) Plik main.tf z referencją do subskrypcji
2) Moze Provider jeśli chcesz to rozłozyc na roznych subskrypcjach
3) I kod pewnie nie działa - więc czeka Cię trochę pracy by go odpowiednio przygotować

## Zadanie 1 - Role i uprawnienia
Generalnie chciałbym byś zmienił kod tak by:
0) Stworzyc min. 2 Resource Groupy w ramach subskrypcji
1) Stworzyc dla siebie dwa konta testowe w ramach Azure AD (tak, masz role :) )
2) Stworzyć podane przez mnie role w ramach Subskrypcji i przypisać je do swoich wybranych kont z AzureAD na poziomie wcześniej utworzych grup zasobów
3) Następnie, chciałbym byś przetestował działanie ról tworząc (nawet z portalu) odpowiednie zasoby
Pomyśl, jak mozesz w ramach organizacji podejść do tematu testowania ról.

## Zadanie 2 - Polityki
1) Zadbaj o to, by definicja Twoich polityk zawierała Twój prefix, by Twoje polityki były unikalne
2) Dodaj definicję polityk do subskrypcji 
3) Przypisz przygotowane definicje polityk do utworzonych wcześniej Grup Zasobów
3) Sprawdź działanie polityk, nawet za pomocą portalu i zobacz czy działają poprawnie.

## Zadanie 3 - Role, Uprawnienia, Polityki - wszystko w kodzie
1) Spróbuj wykonać testy o których mówiłem w zadaniach 1 i 2 ale za pomocą kodu Terraform i zobacz, jaki efekt uzyskasz!