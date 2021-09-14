package ${modelPath}${module}.exception;

public class ${Model}NotFoundException extends Exception {

    public ${Model}NotFoundException(String id) {
        super("${model} not found, id: " + id);
    }

//    public BusinessException businessException() {
//       return new BusinessException(this.getMessage());
//    }

}