# Zjazd 3 - Lab skrócony

## Wstęp
Dostaleś w ramach zadania 3 trochę kodu, który tworzy środowisko.
Kod wymaga zmian i dlatego przed Tobą kilka zadań, które pomogą Ci lepiej je przygotować:
+ 1) Po pierwsze sprawdź plik variables.tf oraz main.tf i upewnij się, ze ID Subskrypcji oraz pozostale parametry maja nazwy, które są zgodne z Twoją konwencją nazewniczą

+ 2) Sprawdź plik rg.tf, tam są zmienne lokalne, gdzie powinieneś poprawić swój prefix uzytkownika

+ 3) Postaraj się doprowadzić kod do takiej postaci by się uruchomił. Jeśli to się uda, osiągnąłeś pierwszy cel!

## Zmiany w kodzie
Aktualnie kod trzyma wszystkie zasoby w jednej grupie zasobów i co więcej wszystkie zasoby są w siedzi HUB. To chyba nie jest poprawne:) Raczej zasoby trzymamy w sieciach Spoke a zasoby w wydzielonych grupach.

Dlatego:
+ 1) Zbuduj prostą strukturę hub-spoke i poza siecią hub wystaw min. 2 inne sieci oraz dostaw peering

+ 2) Dodaje odpowiednie grupy zasobów tak by rozdzielić zasoby o róznych cyklach zycia. Np.:
{PREFIX}-NETOPS-HUB dla sieci HUB
{PREFIX}-NETOPS-DEV-SPOKE dla sieci SPOKE środowiska DEV
{PREFIX}-NETOPS-PRD-SPOKE dla sieci SPOKE środowiska PRD
{PREFIX}-NETOPS-DNS dla usług DNS
{PREFIX}-VM-DEV dla maszyn środowiska DEV
... itd. Tutaj liczę na Twoją inwencję.

Generalnie zmierzamy do tego by rozłozyc odpowiednio nasz kod!

!UWAGA! Prefix jest wazny - pamietaj, ze na tym srodowisku pracuja tez inni :) i mozecie zacząc pisać do tych samych grup zasobow.

!!!UWAGA!!! Jak czujesz się na siłach, mozesz roztawić środowisko po kilku subskrypcjach. Pokazywałem jak to zrobić, łatwo to znaleźć równiez w dokumentacji.

## Poprawki
Środowisko nie jest do końca poprawne :(
Wymienię tylko kilka problemów:
+ 1) maszyna nie pracuje w Availability Set 
2) maszyna ma jawnie podane hasło - moze lepiej je pobrać z KeyVault?
+ 3) KeyVault nie pracuje w dedykowanej sieci, nie ma private endpoint
+ 4) Maszyna ma tylko jeden interfejs sieciowy i tylko jeden dysk na dane. Zmień to uzywając funkcji for_each.

To tylko kilka uwag, ktore miałbym do tego środowiska. Popraw te błędy i wystaw to środowsko lepiej.