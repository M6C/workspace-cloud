package workspace.service;

//http://www.developpez.net/forums/showthread.php?t=20217
//http://java.developpez.com/faq/java/?page=graphique_general_images#GRAPHIQUE_IMAGE_capture_ecran

import java.awt.*;

import java.awt.event.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

import java.util.Calendar;

public class SrvAdminScreenMousePress extends SrvGenerique {
        
    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
        String bouton = request.getParameter("bouton");
        if ((bouton!=null)&&(!bouton.equals(""))) {
        	new Robot().mousePress(Integer.parseInt(bouton));
        }
    }
}