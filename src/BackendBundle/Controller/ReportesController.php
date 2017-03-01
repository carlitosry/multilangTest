<?php

namespace BackendBundle\Controller;

use AppBundle\Entity\Reportes;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use A2lix\I18nDoctrineBundle\Annotation\I18nDoctrine;

/**
 * Reporte controller.
 *
 * @Route("admin/reportes")
 */
class ReportesController extends Controller
{
    /**
     * Lists all reportes entities.
     *
     * @Route("/", name="admin_reportes_index", requirements={"_locale": "en|es|ru"})
     * @Method("GET")
     */
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();

        $reportes = $em->getRepository('AppBundle:Reportes')->findAll();

        return $this->render('reportes/index.html.twig', array(
            'reportes' => $reportes,
        ));
    }

    /**
     * Creates a new reprotes entity.
     *
     * @Route("/new", name="admin_reportes_new")
     * @Method({"GET", "POST"})
     */
    public function newAction(Request $request)
    {
        $reportes = new Reportes();
        $form = $this->createForm('BackendBundle\Form\ReportesType', $reportes );
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($reportes );
            $em->flush($reportes );

            return $this->redirectToRoute('admin_reportes_show', array('id' => $reportes ->getId()));
        }

        return $this->render('reportes/new.html.twig', array(
            'reporte' => $reportes ,
            'form' => $form->createView(),
        ));

    }

    /**
     * Finds and displays a blog entity.
     *
     * @Route("/{_locale}/{id}", name="admin_reportes_show", defaults={"_locale" = "es"}, requirements={
     *         "_locale": "en|es|ru"
     *     })
     * @Method("GET")
     */
    public function showAction($_locale, Request $request, Reportes $reportes)
    {
        $deleteForm = $this->createDeleteForm($reportes);

        return $this->render('reportes/show.html.twig', array(
            'locale' => $_locale,
            'reporte' => $reportes,
            'delete_form' => $deleteForm->createView(),
        ));


    }

    /**
     * Displays a form to edit an existing reportes entity.
     *
     * @Route("/{id}/edit", name="admin_reportes_edit")
     * @Method({"GET", "POST"})
     * @I18nDoctrine
     */
    public function editAction( Request $request, Reportes $reportes )
    {
        $deleteForm = $this->createDeleteForm($reportes );
        $editForm = $this->createForm('BackendBundle\Form\ReportesType', $reportes );
        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('admin_reportes_edit', array('id' => $reportes ->getId()));
        }

        return $this->render('reportes/edit.html.twig', array(
            'reporte' => $reportes ,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Deletes a reprotes entity.
     *
     * @Route("/{id}", name="admin_reportes_delete")
     * @Method("DELETE")
     */
    public function deleteAction(Request $request, Reportes $reportes )
    {
        $form = $this->createDeleteForm($reportes );
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($reportes );
            $em->flush($reportes );
        }

        return $this->redirectToRoute('admin_reportes_index');
    }

    /**
     * Creates a form to delete a reprotes entity.
     *
     * @param Reportes $reportes The reprotes entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(Reportes $reportes )
    {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('admin_reportes_delete', array('id' => $reportes ->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
    }
}
