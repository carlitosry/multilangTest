<?php

namespace BackendBundle\Form;

use A2lix\TranslationFormBundle\Form\Type\TranslationsType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ReportesType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('id')
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
            ]);
    }
    
    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Entity\Reportes'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'backendbundle_reportes';
    }


}
