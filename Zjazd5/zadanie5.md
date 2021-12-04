# Zjazd 5 

## Wstęp
Dostaleś w ramach zadań na kursie trochę kodu do różnych usług.
Najczęsciej jednak nie dodawałeś do usług monitorowania do usługi Log Analytics.
Czas to zmienić :) i pobawić się wróżne możliwości!

## Stwórz usługi
Wierzę, że umiesz tworzyć usługi jednak na potrzeby zadania przyda Ci się:
1) Mała maszyna wirtualna (Linux / Windows - dowolnie)
2) Konto składowania danych
3) Azure App Service (wersja B1 wystarczy :))
4) Prosty klaster AKS (1 node'owy)
5) Redis Cache
6) Azure Search 

## Utwórz Log Analytics
Utwórz usługę Log Analytics w innej RG niż Twoje zasoby. Możesz pokusić się nawet o inną subskrypcję.

## Zadanie 1 
Do wszystkich stworzonych zasobów dodaj konfigurację zbierania logów i metryk do Log Analytics.
Dodaj wszystkie możliwe logi oraz metryki a następnie sprawdź czy w Log Analytics coś się odkłada.
Być może, będzie koniecznie wykonanie jakiejś operacji na klastrze.

## Zadanie 2 
Do maszyn wirtualnych, które stworzyłeś, dodaj agenta Log Analytics.

Sprawdź czy jest to ten sam agent na Linux i Windows a może różny?

Zobacz, jakie jeszcze rozszerzenia możesz w ten sposób zainstalować?

Sprawdź jak w TF możesz konfigurować samą usługę Log Analytics - popatrz na obiekt:
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_datasource_windows_event

A może uda Ci się skonfigurować własne zapisane Query w Azure Log Analytics?
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_saved_search

