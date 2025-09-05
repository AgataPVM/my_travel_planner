import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="sweetalert"
export default class extends Controller {
  connect() {
    console.log("conectou")
  }

  confirm(event) {
    if (!event.isTrusted) return
    event.preventDefault()
    Swal.fire({
      title: "Tem certeza?",
      text: "Não é possível reverter essa ação!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      cancelButtonText: "Cancelar",
      confirmButtonText: "Sim, deletar!"
    }).then((result) => {
      if (result.isConfirmed) {
        this.element.click()
      }
    });
  }
}
