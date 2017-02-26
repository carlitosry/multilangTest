<?php

namespace BackendBundle\Form;

use A2lix\TranslationFormBundle\Form\Type\TranslationsType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Vich\UploaderBundle\Form\Type\VichImageType;

class BlogType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('imageFile',VichImageType::class,array(
                'label' => 'Imagen destacada',
                'required'      => false,
                'allow_delete'  => true, // not mandatory, default is true
                'download_link' => true, // not mandatory, default is true
            ))
            ->add('translations', TranslationsType::class, [
                'locales' => ['es', 'en', 'ru'],   // [1]
                'fields' => [                               // [2]
                    'content' => [                         // [3.a]
                        'field_type' => TextareaType::class,                // [4]
                        'label' => 'descript.',                    // [4]
                        'locale_options' => [                  // [3.b]
                            'en' => ['label' => 'Content'] ,    // [4]
                            'es' => ['label' => 'Contenido'] ,    // [4]
                            'ru' => ['label' => 'Divontenido'] ,    // [4]
                        ],
                        'attr' => [
                            'class' => 'text-editor'
                        ],
                    ]
                ]
            ])
            ->add('images',CollectionType::class,array(
                'label' => false,
                'entry_type' => BlogGalleryType::class,
                'allow_add'    => true,
                'allow_delete' => true,
                'by_reference' => false,
                'required' => true
            ))
        ;
    }
    
    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Entity\Blog'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'backendbundle_blog';
    }


}
