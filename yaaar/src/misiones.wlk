class Mision{
	method puedeCompletarMision(barco){
	return barco.suficienteTripulacion()
	}
}

class BusquedaDelTesoro inherits Mision{
	method esUtil(pirata){
		return self.tieneItemsDelTesoro(pirata) && self.maximo5Monedas(pirata)
	}
	method tieneItemsDelTesoro(pirata){
		return pirata.items().contains("brujula") or pirata.items().contains("mapa") or pirata.items().contains("grogXD")
	}
	method maximo5Monedas(pirata){
		return pirata.cantidadDeDinero() <= 5
	}
	override method puedeCompletarMision(barco){
		super(barco)
		return barco.tripulantes().filter({tripulante => tripulante.items().contains("llaveDeTesoro")}).size() >= 1
	}
}

class ConvertirseEnLeyenda inherits Mision{
	var itemObligatorio
	constructor(_itemObligatorio){
		itemObligatorio = _itemObligatorio
	}
	method esUtil(pirata){
		return pirata.items().contains(itemObligatorio) && pirata.items().size() >= 10
	}
}

class Saqueo inherits Mision{
	var objetivo
	var dineroNecesario
	constructor(_objetivo, _dineroNecesario){
		objetivo = _objetivo
		dineroNecesario = _dineroNecesario
	}
	method esUtil(pirata){
		return pirata.cantidadDeDinero() > dineroNecesario && pirata.seAnimaASaquear(objetivo)
	}
	override method puedeCompletarMision(barco){
		super(barco)
		return objetivo.vulnerableA(barco)
	}
}