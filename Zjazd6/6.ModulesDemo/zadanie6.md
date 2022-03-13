# Zjazd 6 - Moduły w Terraform

## Wstęp 
Dostaleś w ramach tego zjazdu kod modułów. W czasie spotkania zobaczyłeś jak można z nich skorzystać. Czas zatem wziąć to w swoje ręce i napisać kod infrastruktury za pomocą modułów!  Do dzieła.

## Co trzeba zrobić?

W naszym kursie skupiamy się na budowie całej Landing Zone za pomocą kodu Terraform. Robimy to na wielu poziomach. To będzie początek większej infrastruktury!
Pamiętaj, że kod ma rozstawić infrastrukturę w min. dwóch subskrypcjach! Co więcej, kod w nazwach powinien używać przedrostków tak, by nazwy usług i grup były unikalne i niepowtarzalne, byś nie miał konfliktu z innymi, korzystającymi z wspólnego środowiska.

Całość kodu podziel sobie na kilka etapów.

## Opis infrastruktury
1. Zaczynasz od grup zasobów, które są potrzebne pod infrastrukturę sieci.
Będzie to taki zestaw jak niżej:

* RG-HUB - pod sieć HUB - umieszczona w SUBSKRYPCJI 1
* RG-DEV - pod sieć typu SPOKE dla środowiska DEV - umieszczona w SUBSKRYPCJI 2
* RG-MON - pod sieć typu SPOKE dla środowiska do MONITOROWANIA - umieszczona w SUBSKRYPCJI 2 (możesz włączyć jeszcze jedną subskrypcję)

2. Zanim przygotujesz sieci, sprawdź sobie moduły do NSG, Tablic Routingu (RT), VNETu oraz Subnetu i zobacz w jakiej kolejności najlepiej napisać ale potem też powoływać elementy rozwiązania. 

3. Napisz kod za pomocą modułów, który utworzy taki zestaw sieci i podsieci i powoła je w odpowiednich RG.

* VNET-HUB - 10.0.0.0/16, umieść to w grupie dla sieci HUB.
> Subnety
> * GatewaySubnet dla potrzeb umieszenia VPN GW/ER GW

* VNET-DEV - 10.50.0.0/16, umieść to w grupie dla sieci DEV
> Subnety
> * SUBNET-01

* VNET-MON - 10.100.0.0/16, umieść to w grupie dla sieci MON
> Subnety
> * SUBNET-01

> Dodatkowo:
> * VNET-PRD - 10.51.0.0/16, umieść to w grupie dla sieci PRD (jak takiej brakuje, proszę utwórz odpowiednią)
> * VNET-TST - 10.52.0.0/16, umieść to w grupie dla sieci TST (jak takiej brakuje, proszę utwórz odpowiednią)

4. Pamiętaj by do sieci dodać odpowiednie obiekty NSG i RT, które mają w tej architekturze sens!      

5. W przygotowanej architekturze umieść w odpowiednim miejscu usługę Log Analytics. Wybierz dla niej RG oraz oraz subskrypcję. Jeśli dla tej usługi nie znajdziesz modułu, dodaj go proszę sam!
To będzie dobry moment byś przeciwczył budowę własnego modułu!

6. Jesteśmy już blisko celu! Czas na pierwsz usługi środowiska!
* powołaj dowolnie małą maszynę wirtualną VM i dodaj do niej agenta Log Analytics. Zwróć uwagę, że sam Log Analytics może być w innej SUB/RG niż maszyna.
* powołaj dowolnie mały AppService i dodaj do niego zrzucanie logów / monitoringu do Log Analytics. Zwróć uwagę, że sam Log Analytics może być w innej SUB/RG niż AppService.

## Powodzenia!!! Pisze na GitHub jeśli masz pytania!