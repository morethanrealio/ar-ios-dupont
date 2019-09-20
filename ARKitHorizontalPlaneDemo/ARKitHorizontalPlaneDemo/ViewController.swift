//
//  ViewController.swift
//  ARKitHorizontalPlaneDemo
//
//  Created by Jayven Nhan on 11/14/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var spriteView: ARSKView!
    var carro:SCNNode?
    var blindagem:SCNNode?
    var tapReconizer: UITapGestureRecognizer?
    let tempo = 2.0
    @IBOutlet weak var ivSTD: UIImageView!
    @IBOutlet weak var ivRUBI: UIImageView!
    @IBOutlet weak var ivDiamond: UIImageView!
    @IBOutlet weak var ivKevXp: UIImageView!
    
    //var sombra:SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment to configure lighting
        configureLighting()
        addTapGestureToSceneView()
        ivSTD.alpha = 0.0
        ivRUBI.alpha = 0.0
        ivDiamond.alpha = 0.0
        ivKevXp.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    // botoes de resize
    // primeiro botao
    @IBAction func Aumentar(_ sender: Any) {
        if carro != nil {
           let tamanhodoCarro = SCNVector3(0.008,0.008,0.008)
            let ofset = SCNVector3(0.00801,0.00801,0.00801)
            carro?.scale = tamanhodoCarro
            blindagem?.scale = ofset
            //sombra?.scale = tamanhodoCarro
            }

    }
    
    //segundo botao
    @IBAction func segundoMaior(_ sender: Any) {
        if carro != nil {
           let tamanhodoCarro = SCNVector3(0.006,0.006,0.006)
            let ofset = SCNVector3(0.00601,0.00601,0.00601)
            carro?.scale = tamanhodoCarro
            blindagem?.scale = ofset
            //sombra?.scale = tamanhodoCarro
        }
    }
    
    
    // terceiro botao
    @IBAction func Medio(_ sender: Any) {
        if carro != nil {
           let tamanhodoCarro = SCNVector3(0.003,0.003,0.003)
            let ofset = SCNVector3(0.00301,0.00301,0.00301)
            carro?.scale = tamanhodoCarro
            blindagem?.scale = ofset
            //sombra?.scale = tamanhodoCarro
        }
        
    }
    
    // quarto botao
    @IBAction func segundoMenor(_ sender: Any) {
        if carro != nil {
           let tamanhodoCarro = SCNVector3(0.001,0.001,0.001)
            let ofset = SCNVector3(0.00101,0.00101,0.00101)
            carro?.scale = tamanhodoCarro
            blindagem?.scale = ofset
            //sombra?.scale = tamanhodoCarro
        }
    }
    
    
    // quinto botao
    @IBAction func Diminuir(_ sender: Any) {
                if carro != nil {
           let tamanhodoCarro = SCNVector3(0.0005,0.0005,0.0005)
           let ofset = SCNVector3(0.00051,0.00051,0.00051)
            carro?.scale = tamanhodoCarro
            blindagem?.scale = ofset
            //sombra?.scale = tamanhodoCarro
        }
    }
    //fim do resize
    
    // botoes da blindagem
    
    @IBAction func adicionarSTD(_ sender: Any) {
        if carro != nil {
            
            ivSTD.alpha = 1.0
            ivRUBI.alpha = 0.0
            ivDiamond.alpha = 0.0
            carro?.opacity = 0.7
            blindagem?.opacity = 1.0
            blindagem?.geometry?.material(named: "placa")?.diffuse.contents = UIColor.yellow
            blindagem?.geometry?.material(named: "PlacaColuna")?.diffuse.contents = UIColor.orange
        }
    }
    
    @IBAction func adicionarRUBI(_ sender: Any) {
        if carro != nil {
            ivRUBI.alpha = 1.0
            ivSTD.alpha = 0.0
            ivDiamond.alpha = 0.0
            carro?.opacity = 0.7
            blindagem?.opacity = 1.0
            blindagem?.geometry?.material(named: "placa")?.diffuse.contents = UIColor.orange
            blindagem?.geometry?.material(named: "PlacaColuna")?.diffuse.contents = UIColor.red
        }
    }
    
    @IBAction func adicionarDiamond(_ sender: Any) {
        if carro != nil {
            ivDiamond.alpha = 1.0
            ivSTD.alpha = 0.0
            ivRUBI.alpha = 0.0
            carro?.opacity = 0.7
            blindagem?.opacity = 1.0
            blindagem?.geometry?.material(named: "placa")?.diffuse.contents = UIColor.red
            blindagem?.geometry?.material(named: "PlacaColuna")?.diffuse.contents = UIColor.black
        }
    }
//    fim dos botoes da blindagem
    
    // Exeperiencia Kevlar
    
    @IBAction func habilitarTiro(_ sender: Any) {
        
        if ivKevXp.alpha == 0.0 {
            ivKevXp.alpha = 1.0
        }
        else{
            ivKevXp.alpha = 0.0
        }
        // adiciona um tap Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        
        
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
         
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            
            // retrieved the first clicked object
            let result = hitResults[0]
            
            let posicao = result.localCoordinates
            //let matriz = simd_float4x4(posicao)
            let plano = SCNNode.init(geometry: SCNPlane(width: 0.2, height: 0.2))
            plano.position = posicao
            plano.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "logo.png")
            plano.geometry?.firstMaterial?.isDoubleSided = true
            result.node.addChildNode(plano)
            
            print("acertou: \(result.node.name)")
        }
    }
    
    // Colocar o carro na cena
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer){
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        guard let shipScene = SCNScene(named: "Mercedes_002.scn"),
            let carNode = shipScene.rootNode.childNode(withName: "car", recursively: false),
            let sphereNode = shipScene.rootNode.childNode(withName: "sphere", recursively: false),
            let blindagemNode = shipScene.rootNode.childNode(withName: "Placas_02", recursively: false)
        else {
            print("not found")
            return
        }
        
        blindagemNode.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(blindagemNode)
        blindagemNode.opacity = 0.0
        blindagem = blindagemNode
        
        
        carNode.position = SCNVector3(x + 2.0,y,z)
        sceneView.scene.rootNode.addChildNode(carNode)
        let rodaD_ENode = carNode.childNode(withName: "rodaD_E", recursively: false)
        let rodaD_DNode = carNode.childNode(withName: "rodaD_D", recursively: false)
        let rodaT_ENode = carNode.childNode(withName: "rodaT_E", recursively: false)
        let rodaT_DNode = carNode.childNode(withName: "rodaT_D", recursively: false)
        
        carro = carNode
        SCNTransaction.begin()
        SCNTransaction.animationDuration = tempo
        carNode.position.x -= 2.0
        
        SCNTransaction.commit()
        
        let animation = CABasicAnimation(keyPath: "transform.eulerAngles.x")
        animation.toValue = NSNumber(value: Double.pi*2.0)
        animation.duration = 1.0
        animation.autoreverses = false
        //animation.repeatCount = .infinity
        animation.repeatDuration = tempo
        rodaT_ENode?.addAnimation(animation, forKey: "roda")
        
        
        rodaD_ENode?.addAnimation(animation, forKey: "roda")
    
        
        let animation2 = CABasicAnimation(keyPath: "transform.eulerAngles.x")
        animation2.toValue = NSNumber(value: -Double.pi*2.0)
        animation2.duration = 1.0
        animation2.autoreverses = false
        //animation2.repeatCount = .infinity
        animation2.repeatDuration = tempo
        rodaD_DNode?.addAnimation(animation2, forKey: "roda2")
        
        
        rodaT_DNode?.addAnimation(animation2, forKey: "roda2")
        
        
        sphereNode.position = SCNVector3(x + 0.2, y + 0.01, z + 0.1)
        sceneView.scene.rootNode.addChildNode(sphereNode)
        
        tapReconizer?.isEnabled = false
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        sceneView.addGestureRecognizer(swipeRecognizer)
        swipeRecognizer.delegate = self
        
        let pinchRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        sceneView.addGestureRecognizer(pinchRecognizer)
        pinchRecognizer.delegate = self
        
    }
    
    @objc
       func handleSwipe(_ gestureRecognize: UIGestureRecognizer) {
        
    }
    
    @objc
       func handlePinch(_ gestureRecognize: UIGestureRecognizer) {
        
        
        
    }
    
    
    //Quando o usuario toca na tela chama a funcao de colocar carro
    func addTapGestureToSceneView(){
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addShipToSceneView(withGestureRecognizer:)))
            tapGestureRecognizer.delegate = self
            sceneView.addGestureRecognizer(tapGestureRecognizer)
          tapReconizer = tapGestureRecognizer
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        // setando o plano horizontal
        configuration.planeDetection = .horizontal
        // abilitando os materiais com a textura do ambiente
        configuration.environmentTexturing = .automatic
        
        sceneView.session.run(configuration)
        
        //associando o delegate a propria ViewController
        sceneView.delegate = self
        //ferramestas para debugar
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.showsStatistics = true
    }
    
    // Configuracao de iluminacao da cena AR
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
}

// extencao Delegate da ViewController
extension ViewController: ARSCNViewDelegate{
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //1
        guard let planeAnchor = anchor as? ARPlaneAnchor
            else {return}
        
        //2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        //3
        plane.materials.first?.diffuse.contents = UIColor.clear
        
        //4
        let planeNode = SCNNode(geometry: plane)
        
        
        //5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
        planeNode.eulerAngles.x =  -.pi/2
        
        //6
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //1
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
        else { return }
        
        //2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        //3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
    
}

extension ViewController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentLightBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.50)
    }
}
