copy ..\..\KiraStudioPrivate\KiraStudio\Resources\Images\Generator*.tga .\docs\images\
copy ..\..\KiraStudioPrivate\KiraStudio\Resources\Images\Effect*.tga .\docs\images\
del /q .\docs\images\*@2x.tga 
del /q .\docs\images\*@4x.tga
magick mogrify -format png .\docs\images\*.tga
del /q .\docs\images\*.tga
