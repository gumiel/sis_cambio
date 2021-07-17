<?php

/**
*@package PXP
*@file ACTServicio.php
*@author  (admin)
*@date 29-06-2021 02:21:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTServicio extends ACTbase{    
      
  function __construct(){
    
  }  
        
  function insertarServicio(){
    $this->objFunc=$this->create('MODServicio');	
    // if($this->objParam->insertar('id_servicio')){
    //   $this->res=$this->objFunc->insertarServicio($this->objParam);			
    // } else{			
    //   $this->res=$this->objFunc->modificarServicio($this->objParam);
    // }
    // $this->res->imprimirRespuesta($this->res->generarJson());
  }
            
  
      
}

