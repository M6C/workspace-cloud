package workspace.action;


//http://www.developpez.net/forums/showthread.php?t=20217
//http://java.developpez.com/faq/java/?page=graphique_general_images#GRAPHIQUE_IMAGE_capture_ecran

import java.awt.*;

import java.awt.event.*;
import java.awt.image.*;
import java.io.*;

import javax.imageio.*;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.ImageIcon;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.image.codec.jpeg.JPEGEncodeParam;

import framework.ressource.util.UtilString;
import framework.ressource.util.image.Quantize;

import java.util.Calendar;

public class ActionScreenShoot extends framework.action.ActionScreenShoot {
    
    protected Image getImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String x = request.getParameter("mousex");
        String y = request.getParameter("mousey");

        if (UtilString.isNotEmpty(x) &&
            UtilString.isNotEmpty(y)) {
            try {
                new Robot().mouseMove(Integer.parseInt(x), Integer.parseInt(y));
            }
            catch (Exception ex) {
            }
        }
        return super.getImage(request, response);
    }
}