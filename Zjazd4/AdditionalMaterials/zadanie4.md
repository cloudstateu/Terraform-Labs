# Zjazd 4.5 - Dodatkowe

## Wstęp
Witaj w zadaniu dodatkowym! 
By trochę ułatwić Ci pracę, załączam dwa pliki, dostępne w tym folderze.

Pierwszy SzkolaChmury - Polityki.pdf pokazuje zestaw polityk, który mozesz wykorzystać w firmie.
Plik SzkolaChmury - Terraform - RoleGovernance.pdf pokazuje rózne role, których mozna uzyć w firmie. 

Pamiętaj "One Size Does Not Fit All" dlatego są to tylko propozycje, które musisz przemyśleć i zaadoptować w swoim środowisku a następnie sprawdzić czy procesowo, potrafisz tak pracować. (szczególnie w przypadku roli)

## Dodatkowa praca domowa 
Dostałeś od mnie pokazny zestaw kodu a teraz kilka propozycji polityk oraz ról.
Chciałbym byś sam wykazał się kreatywnością i wykonał kilka testów tak, aby:

### 1) Utworzyć dowolną, jedną z ról, którą znajdziesz w opisie. 
Samo utworzenie roli to nie wszystko - warto przetestować czy rola działa zgodnie z załozeniami tj, czy pozwala na określone akcje, które chciałeś i blokuje te, które są z Twojej perspektywy nie potrzebne.
W tego typu pracy przydaje się "robienie" zrzutów ekranu dla testów.
Testy można prowadzić z portalu ale nie polecam by to była jedyna metoda. 

### 2) Utworzyć zestaw polityk i przetestować ich działanie 
W opisie zaproponowałem Ci cały zestaw polityk. 
Spróbuj, korzystając z referencji do kodu polityk (też są w opisie) wdrożyć w swojej subskrypcji lub ew. w grupie zasobów takie polityki, które (jeśli operacja Deny nie będzie możliwa to wykorzystaj operację Audit):
1) Zabronią tworzenia usługi Azure SQL bez Private Endpoint'ów
2) Zabronią tworzenia usługi Azure Storage Account bez Private Endpoint'ów
3) Zabronią tworzenia usługi Azure SQL bez włączonego monitorowania za pomocą Log Analytics
Po utworzeniu takich polityk postaraj się z Terraform wdrożyć usługi:
- Azure SQL
- Storage Account 
- Azure MySQL 
i w ramach rozwiązania napisz na jakie trudności natrafiłeś!

# POWODZENIA #