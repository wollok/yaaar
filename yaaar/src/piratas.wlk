class Pirata{
	var items = new List()
	var nivelDeEbriedad
	var cantidadDeDinero
	var genteQueInvito = 0
	var invitadoPor
	constructor(_items, _nivelDeEbriedad, _cantidadDeDinero){
		items = _items
		nivelDeEbriedad = _nivelDeEbriedad
		cantidadDeDinero = _cantidadDeDinero
	}
	method items(){return items}
	method items(nuevosItems){self.items().add(nuevosItems)}
	method nivelDeEbriedad(){return nivelDeEbriedad}
	method cantidadDeDinero(){return cantidadDeDinero}
	method invitadoPor(){return invitadoPor}
	method invitadoPor(persona){invitadoPor = persona}
	method genteQueInvito(){return genteQueInvito}
	
	method pasadoDeGrog(){
		return nivelDeEbriedad >= 90
	}
	method tomarGrog(cantidad){
		nivelDeEbriedad += cantidad
	}
	method gastarMonedas(cantidad){
		cantidadDeDinero += cantidad
		//poner error si no puede gastar moneda
	}
	method seAnimaASaquear(objetivo){
		return self.nivelDeEbriedad() >= 50
	}
	method invitar(persona,barco){
		barco.incorporar(persona)
		persona.invitadoPor(self)
		genteQueInvito+=1
	}
}
	
//var barbanegra = new Pirata(["brujula", "cuchillo", "cuchillo", "dienteDeOro", "grogXD", "grogXD", "grogXD"],,)

class EspiaDeLaCorona inherits Pirata{
	override method pasadoDeGrog(){
		return false
	}
	override method seAnimaASaquear(objetivo){
		super(objetivo)
		return self.items().contains("permisoDeLaCorona")
	}
}