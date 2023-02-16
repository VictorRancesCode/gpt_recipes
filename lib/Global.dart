class Global {
  static String token = "Your Token";
  static dynamic languages = {
    "en": {
      "alertDescriptionVal":
          "The amount of ingredients entered must be greater than 2",
      "alertTitleValidation": "Validations",
      "prompt":
          "generate a recipe with only the following ingredients: {value}. Maximum 10 ingredients, their instructions on how to do it, all in a json string object divided by name that is the name of the recipe, ingredients, instructions, a vector with the instructions and 'image' is description of the recipe already prepared to generate a maximum image of 1000 characters",
      "alertErrorTitle": "Communication Error",
      "alertErrorDes": "Try again!",
      "titleHome":
          "Could you tell me what ingredients are available for the recipe?",
      "exampleHome": "Example: rice, lettuce, chicken, potatoes",
      "helpHome":
          'Important! Separate ingredients by commas ",". \nEnter at least 3 ingredients',
      "buttonHome": "Generate Recipe",
      "ingredients": "Ingredients",
      "instructions": "Instructions"
    },
    "es": {
      "alertDescriptionVal":
          "La cantidad de ingredientes ingresados, tienen que ser mayor a 2",
      "alertTitleValidation": "Validaciones",
      "prompt":
          "generame una receta con solo  los siguientes ingredientes: {value}. Máximo 10 ingredientes, su instrucciones de como realizarlo, todo en un objeto json string dividido por name que es el nombre de la receta, ingredients, instructions un vector con las instrucciones y 'image' is descripción de la receta ya preparada para generar una imagen máximo de 1000 caracteres",
      "alertErrorTitle": "Error de comunicación",
      "alertErrorDes": "¡Intente nuevamente!",
      "titleHome":
          "¿Podrías informarme que ingredientes disponibles tienes para la receta?",
      "exampleHome": "Ejemplo: arroz, lechuga, pollo, papas",
      "helpHome":
          'Importante! separar los ingredientes por coma ",". \nIngresar al menos 3 ingredientes',
      "buttonHome": "Generar Receta",
      "ingredients": "Ingredientes",
      "instructions": "Instrucciones"
    }
  };
}
