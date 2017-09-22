class BarcoPirata{
	var mision
	var tripulantes = new List()
	var capacidad
	var itemsDeTripulantes = new Set()
	constructor (_mision, _tripulantes, _capacidad){
		mision = _mision
		tripulantes = _tripulantes
		capacidad = _capacidad
	}
	method mision(){return mision}
	method mision(nuevaMision){
		mision = nuevaMision
		self.tripulantes(self.tripulantes().filter({tripulante => self.tieneLugar(tripulante)}))
	}
	method tripulantes(){return tripulantes}
	method tripulantes(nuevosTripulantes){tripulantes = nuevosTripulantes}
	method capacidad(){return capacidad}
	method capacidad(cantidad){capacidad = cantidad}
	method itemsDeTripulantes(){return itemsDeTripulantes}
	method itemsDeTripulantes(_itemsDeTripulantes){itemsDeTripulantes.addAll(_itemsDeTripulantes)}
	method temible(){
		return mision.puedeCompletarMision(self)
	}
	method suficienteTripulacion(){
		return self.tripulantes().size() >= 0.9*self.capacidad()
	}
	method saqueadoPor(pirata){
		return pirata.pasadoDeGrog()
	}
	method vulnerableA(barco){
		return self.capacidad().max(barco.capacidad())
	}
	method tieneLugar(pirata){
		return self.hayLugarParaUnoMas() && mision.esUtil(pirata)
	}
	method hayLugarParaUnoMas(){
		return self.tripulantes().size() < capacidad
	}
	method incorporar(pirata){
		if(self.tieneLugar(pirata)){
			self.tripulantes().add(pirata)
		}
	}
	method masEbrio(){
		return self.tripulantes().max({tripulante => tripulante.nivelDeEbriedad()})
	}
	method anclar(ciudadCostera){
		self.tripulantes().forEach({tripulante => tripulante.tomarGrog(5)})
		self.tripulantes().forEach({tripulante => tripulante.gastarMonedas(1)})
		self.sePerdio(self.masEbrio(), ciudadCostera)
	}
	method sePerdio(pirata, ciudadCostera){
		self.tripulantes().remove(pirata)
		ciudadCostera.sumarHabitantes(1)
	}
	method pasadosDeGrog(){
		return self.tripulantes().filter({tripulante => tripulante.pasadoDeGrog()})
	}
	method elPasadoConMasPlata(){
		return self.pasadosDeGrog().max({pasado => pasado.cantidadDeDinero()})
	}
	method elQueMasInvito(){
		return self.tripulantes().max({tripulante => tripulante.genteQueInvito()})
	}
	method juntarItemsDeLosPasados(){
		self.itemsDeTripulantes(self.pasadosDeGrog().map({pasado => pasado.items()}).flatten())
	}
}

class CiudadCostera{
	var habitantes
	constructor(_habitantes){
		habitantes = _habitantes
	}
	method habitantes(){return habitantes}
	method sumarHabitantes(cantidad){
		habitantes += cantidad
	}
	method vulnerableA(barco){
		return barco.tripulantes().size() >= 0.4*self.habitantes() or barco.tripulantes().forAll({tripulante => tripulante.pasadoDeGrog()})
	}
}
