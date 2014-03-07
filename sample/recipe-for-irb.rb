# coding: utf-8
    @ww      = BreadCalculator::Ingredient.new "whole wheat flour", :quantity => 300, :units => 'grams', :type=>:flours
    @ap      = BreadCalculator::Ingredient.new "all purpose flour", :quantity => 700, :units => 'grams', :type=>:flours
    @water   = BreadCalculator::Ingredient.new "water", :quantity => 550, :units => 'grams', :type=>:liquids
    @egg     = BreadCalculator::Ingredient.new "egg", :quantity => 40, :units => 'grams', :type=>:liquids
    @milk    = BreadCalculator::Ingredient.new "dry milk", :quantity => 40, :units => 'grams', :type=>:additives
    @raisins = BreadCalculator::Ingredient.new "raisins", :quantity => 50, :units => 'grams', :type=>:additives
    @yeast   = BreadCalculator::Ingredient.new "yeast", :quantity => 20, :units => 'grams', :type=>:additives
    @proof   = BreadCalculator::Step.new 'Rehydrate', @yeast
    @wet     = BreadCalculator::Step.new 'in', @water, @egg
    @dry     = BreadCalculator::Step.new 'Mix together:', @ww, @ap, @milk, 'in  a large bowl'
    @mix     = BreadCalculator::Step.new 'Combine wet and dry ingredients with', @raisins
    @bake    = BreadCalculator::Step.new 'Form a loaf, rise for 2 hours, Bake at 375° for 45 minutes.'
    @meta    = {:notes => 'nice sandwich bread'}
    @recipe  = BreadCalculator::Recipe.new @meta, [@proof, @wet, @dry, @mix, @bake]
