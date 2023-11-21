import { Controller } from "@hotwired/stimulus"

export default class ImageUploadPreview extends Controller {
  static targets = [ "input", "preview" ]
  
  setImagePreview() {
    const input = this.inputTarget
    const preview = this.previewTarget
    
    if (input.files && input.files[0]) {
      const reader = new FileReader()
      const image = input.files[0]

      reader.onload = () => {
        preview.src = reader.result
      }

      reader.readAsDataURL(image)
    }
  }
}
