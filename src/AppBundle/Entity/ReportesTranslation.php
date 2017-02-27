<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="reportes_translation")
 */
class ReportesTranslation implements \A2lix\I18nDoctrineBundle\Doctrine\Interfaces\OneLocaleInterface
{
    use \A2lix\I18nDoctrineBundle\Doctrine\ORM\Util\Translation;

    /**
     * @ORM\Column(type="string", length=255)
     */
    protected $title;

    /**
     * @ORM\Column( type="text", length=255)
     */
    protected $content;

    /**
     * @ORM\Column(type="text", length=255)
     */
    protected $notas;


    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * @param mixed
     */
    public function setTitle($title)
    {
        $this->title = $title;
    }

    /**
     * @return mixed
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * @param mixed $content
     */
    public function setContent($content)
    {
        $this->content = $content;

    }

    /**
     * @return mixed
     */
    public function getLocale()
    {
        return $this->locale;
    }

    /**
     * @param mixed $locale
     */
    public function setLocale($locale)
    {
        $this->locale = $locale;
    }

    /**
     * @return mixed
     */
    public function getContent()
    {
        return $this->content;
    }

    /**
     * @param mixed $notas
     */
    public function setNotas($notas)
    {
        $this->notas = $notas;
    }

    /**
     * @return mixed
     */
    public function getNotas()
    {
        return $this->notas;
    }
}
